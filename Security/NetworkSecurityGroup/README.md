# Azure Network Security Group Terraform Module

This module creates an Azure Network Security Group (NSG) with configurable security rules, preset rule options, and diagnostic settings.

## Features

- Fully configurable NSG with custom security rules
- Preset rules for common scenarios (SSH, RDP, HTTP, HTTPS)
- Application Security Group (ASG) support
- Service Tags support
- Diagnostic settings for monitoring and compliance
- Flexible naming convention with prefix/suffix support
- `create` flag to enable/disable resource creation

## Dependencies

Before using this module, ensure the following resources exist:

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | The NSG must be created within an existing Resource Group |
| Application Security Group | No | Only if using ASG IDs in rules |
| Log Analytics Workspace | No | Only if `diagnostic_settings` requires it |
| Storage Account | No | Only if diagnostic logs need archival |
| Event Hub | No | Only if streaming diagnostics to Event Hub |

## Usage

### Basic Example

```hcl
module "nsg" {
  source = "../../Networking/NetworkSecurityGroup"

  # DEPENDENCY: Resource Group must exist
  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"

  name = "nsg-web-dev-001"

  tags = {
    Environment = "Development"
    Project     = "MyProject"
  }
}
```

### With Custom Security Rules

```hcl
module "nsg" {
  source = "../../Networking/NetworkSecurityGroup"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"
  name                = "nsg-web-dev-001"

  security_rules = {
    "AllowHTTPS" = {
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "Allow HTTPS traffic"
    }
    "AllowHTTP" = {
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "Allow HTTP traffic"
    }
    "DenyAllInbound" = {
      priority                   = 4096
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "Deny all other inbound traffic"
    }
  }
}
```

### Using Preset Rules

```hcl
module "nsg" {
  source = "../../Networking/NetworkSecurityGroup"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"
  name                = "nsg-bastion-dev-001"

  # Use preset rules for common scenarios
  allow_ssh = {
    enabled               = true
    priority              = 100
    source_address_prefix = "10.0.0.0/8"  # Only allow from internal networks
  }

  allow_rdp = {
    enabled               = true
    priority              = 110
    source_address_prefix = "10.0.0.0/8"
  }

  deny_all_inbound = {
    enabled  = true
    priority = 4096
  }
}
```

### Web Server NSG with Preset Rules

```hcl
module "nsg_web" {
  source = "../../Networking/NetworkSecurityGroup"

  resource_group_name = "rg-networking-prod-001"
  location            = "westeurope"
  name                = "nsg-web-prod-001"

  allow_https = {
    enabled               = true
    priority              = 100
    source_address_prefix = "Internet"  # Service tag
  }

  allow_http = {
    enabled               = true
    priority              = 110
    source_address_prefix = "Internet"
  }

  # Additional custom rules
  security_rules = {
    "AllowLoadBalancer" = {
      priority                   = 150
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "AzureLoadBalancer"
      destination_address_prefix = "*"
      description                = "Allow Azure Load Balancer"
    }
  }

  deny_all_inbound = {
    enabled = true
  }
}
```

### With Multiple Source Addresses

```hcl
module "nsg" {
  source = "../../Networking/NetworkSecurityGroup"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"
  name                = "nsg-mgmt-dev-001"

  allow_ssh = {
    enabled = true
    priority = 100
    source_address_prefixes = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  }
}
```

### With Diagnostic Settings

```hcl
module "nsg" {
  source = "../../Networking/NetworkSecurityGroup"

  resource_group_name = "rg-networking-prod-001"
  location            = "westeurope"
  name                = "nsg-web-prod-001"

  allow_https = { enabled = true }

  diagnostic_settings = {
    name                       = "diag-nsg-web"
    log_analytics_workspace_id = "/subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.OperationalInsights/workspaces/law-001"
    log_categories             = ["NetworkSecurityGroupEvent", "NetworkSecurityGroupRuleCounter"]
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the NSG | `bool` | `true` | no |
| resource_group_name | Resource Group name (DEPENDENCY) | `string` | n/a | **yes** |
| location | Azure region (DEPENDENCY) | `string` | n/a | **yes** |
| name | Explicit name for the NSG | `string` | `null` | no |
| name_prefix | Prefix for generated name | `string` | `"nsg"` | no |
| name_suffix | Suffix for generated name | `string` | `""` | no |
| workload | Workload name for naming convention | `string` | `"default"` | no |
| environment | Environment name for naming convention | `string` | `"dev"` | no |
| instance | Instance identifier | `string` | `"001"` | no |
| security_rules | Map of custom security rules | `map(object({...}))` | `{}` | no |
| allow_ssh | Preset rule for SSH | `object({...})` | `{enabled=false}` | no |
| allow_rdp | Preset rule for RDP | `object({...})` | `{enabled=false}` | no |
| allow_https | Preset rule for HTTPS | `object({...})` | `{enabled=false}` | no |
| allow_http | Preset rule for HTTP | `object({...})` | `{enabled=false}` | no |
| deny_all_inbound | Preset rule to deny all inbound | `object({...})` | `{enabled=false}` | no |
| tags | Tags to assign to resources | `map(string)` | `{}` | no |
| diagnostic_settings | Diagnostic settings config (DEPENDENCY) | `object({...})` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the NSG |
| name | The name of the NSG |
| resource_group_name | The Resource Group name |
| location | The Azure region |
| security_rule_ids | Map of rule names to IDs |
| security_rules | Map of rule names to configurations |
| diagnostic_settings_id | ID of diagnostic settings (if created) |

## Common Service Tags

| Tag | Description |
|-----|-------------|
| `Internet` | Public internet |
| `VirtualNetwork` | Virtual network address space |
| `AzureLoadBalancer` | Azure Load Balancer health probes |
| `AzureTrafficManager` | Traffic Manager probe IPs |
| `Storage` | Azure Storage |
| `Sql` | Azure SQL Database |
| `AzureCosmosDB` | Azure Cosmos DB |
| `AzureKeyVault` | Azure Key Vault |
| `AzureActiveDirectory` | Azure AD |
| `AzureMonitor` | Azure Monitor |

## Security Recommendations

1. **Principle of Least Privilege**: Only allow necessary traffic
2. **Use Service Tags**: Prefer service tags over IP ranges when possible
3. **Deny by Default**: Add explicit deny rules at lowest priority
4. **Enable Logging**: Always enable diagnostic settings in production
5. **Use ASGs**: Group VMs with similar functions using Application Security Groups
6. **Regular Audits**: Periodically review and clean up unused rules
7. **Avoid "*" Sources**: Restrict source addresses when possible

## Notes

- NSG rules are stateful (return traffic is automatically allowed)
- Priority range is 100-4096 (lower numbers evaluated first)
- Azure has default rules that cannot be deleted (priorities 65000-65500)
- NSG flow logs require Network Watcher in the region

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0, < 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allow_http"></a> [allow\_http](#input\_allow\_http) | (Optional) Enable a preset rule to allow HTTP (port 80) from specified sources. | <pre>object({<br/>    enabled                = bool<br/>    priority               = optional(number, 130)<br/>    source_address_prefix  = optional(string, "*")<br/>    source_address_prefixes = optional(list(string), null)<br/>  })</pre> | <pre>{<br/>  "enabled": false<br/>}</pre> | no |
| <a name="input_allow_https"></a> [allow\_https](#input\_allow\_https) | (Optional) Enable a preset rule to allow HTTPS (port 443) from specified sources. | <pre>object({<br/>    enabled                = bool<br/>    priority               = optional(number, 120)<br/>    source_address_prefix  = optional(string, "*")<br/>    source_address_prefixes = optional(list(string), null)<br/>  })</pre> | <pre>{<br/>  "enabled": false<br/>}</pre> | no |
| <a name="input_allow_rdp"></a> [allow\_rdp](#input\_allow\_rdp) | (Optional) Enable a preset rule to allow RDP (port 3389) from specified sources. | <pre>object({<br/>    enabled                = bool<br/>    priority               = optional(number, 110)<br/>    source_address_prefix  = optional(string, "*")<br/>    source_address_prefixes = optional(list(string), null)<br/>  })</pre> | <pre>{<br/>  "enabled": false<br/>}</pre> | no |
| <a name="input_allow_ssh"></a> [allow\_ssh](#input\_allow\_ssh) | (Optional) Enable a preset rule to allow SSH (port 22) from specified sources. | <pre>object({<br/>    enabled                = bool<br/>    priority               = optional(number, 100)<br/>    source_address_prefix  = optional(string, "*")<br/>    source_address_prefixes = optional(list(string), null)<br/>  })</pre> | <pre>{<br/>  "enabled": false<br/>}</pre> | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Network Security Group. Set to false to disable resource creation without removing module code. | `bool` | `true` | no |
| <a name="input_deny_all_inbound"></a> [deny\_all\_inbound](#input\_deny\_all\_inbound) | (Optional) Enable a preset rule to deny all inbound traffic (lowest priority). | <pre>object({<br/>    enabled  = bool<br/>    priority = optional(number, 4096)<br/>  })</pre> | <pre>{<br/>  "enabled": false<br/>}</pre> | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | (Optional) Diagnostic settings configuration for the NSG.<br/>DEPENDENCY: Log Analytics Workspace, Storage Account, or Event Hub must exist.<br/><br/>Attributes:<br/>  - name: Name of the diagnostic setting.<br/>  - log\_analytics\_workspace\_id: Resource ID of the Log Analytics Workspace.<br/>  - storage\_account\_id: Resource ID of the Storage Account for archival.<br/>  - eventhub\_authorization\_rule\_id: Authorization rule ID for Event Hub.<br/>  - eventhub\_name: Name of the Event Hub.<br/>  - log\_categories: List of log categories to enable. | <pre>object({<br/>    name                           = optional(string, "diag-nsg")<br/>    log_analytics_workspace_id     = optional(string, null)<br/>    storage_account_id             = optional(string, null)<br/>    eventhub_authorization_rule_id = optional(string, null)<br/>    eventhub_name                  = optional(string, null)<br/>    log_categories                 = optional(list(string), ["NetworkSecurityGroupEvent", "NetworkSecurityGroupRuleCounter"])<br/>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) The environment name (e.g., dev, staging, prod), used for naming convention. | `string` | `"dev"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number or identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure region where the NSG will be deployed.<br/>DEPENDENCY: Should match the Resource Group location. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The explicit name for the NSG. If provided, overrides name\_prefix/name\_suffix logic. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix to prepend to the generated NSG name. Used when 'name' is not provided. | `string` | `"nsg"` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | (Optional) Suffix to append to the generated NSG name. Used when 'name' is not provided. | `string` | `""` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the NSG will be created.<br/>DEPENDENCY: Resource Group must exist before creating the NSG. | `string` | n/a | yes |
| <a name="input_security_rules"></a> [security\_rules](#input\_security\_rules) | (Optional) Map of security rules to create in the NSG.<br/><br/>Attributes:<br/>  - priority: Rule priority (100-4096). Lower numbers are evaluated first.<br/>  - direction: "Inbound" or "Outbound".<br/>  - access: "Allow" or "Deny".<br/>  - protocol: "Tcp", "Udp", "Icmp", "Esp", "Ah", or "*".<br/>  - source\_port\_range: Source port or range (e.g., "80", "80-443", "*").<br/>  - source\_port\_ranges: List of source ports (alternative to source\_port\_range).<br/>  - destination\_port\_range: Destination port or range.<br/>  - destination\_port\_ranges: List of destination ports.<br/>  - source\_address\_prefix: Source CIDR, service tag, or "*".<br/>  - source\_address\_prefixes: List of source CIDRs.<br/>  - source\_application\_security\_group\_ids: List of source ASG IDs.<br/>  - destination\_address\_prefix: Destination CIDR, service tag, or "*".<br/>  - destination\_address\_prefixes: List of destination CIDRs.<br/>  - destination\_application\_security\_group\_ids: List of destination ASG IDs.<br/>  - description: Optional rule description. | <pre>map(object({<br/>    priority                                   = number<br/>    direction                                  = string<br/>    access                                     = string<br/>    protocol                                   = string<br/>    source_port_range                          = optional(string, null)<br/>    source_port_ranges                         = optional(list(string), null)<br/>    destination_port_range                     = optional(string, null)<br/>    destination_port_ranges                    = optional(list(string), null)<br/>    source_address_prefix                      = optional(string, null)<br/>    source_address_prefixes                    = optional(list(string), null)<br/>    source_application_security_group_ids      = optional(list(string), null)<br/>    destination_address_prefix                 = optional(string, null)<br/>    destination_address_prefixes               = optional(list(string), null)<br/>    destination_application_security_group_ids = optional(list(string), null)<br/>    description                                = optional(string, null)<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the NSG. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) The workload or purpose name, used for naming convention. | `string` | `"default"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_diagnostic_settings_id"></a> [diagnostic\_settings\_id](#output\_diagnostic\_settings\_id) | The ID of the diagnostic settings (if created). |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Network Security Group. |
| <a name="output_location"></a> [location](#output\_location) | The Azure region where the NSG is deployed. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Network Security Group. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the Resource Group containing the NSG. |
| <a name="output_security_rule_ids"></a> [security\_rule\_ids](#output\_security\_rule\_ids) | Map of security rule names to their IDs. |
| <a name="output_security_rules"></a> [security\_rules](#output\_security\_rules) | Map of security rule names to their full configuration. |
<!-- END_TF_DOCS -->