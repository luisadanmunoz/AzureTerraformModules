# Azure Virtual Network Terraform Module

This module creates an Azure Virtual Network (VNet) with optional inline subnets, DDoS protection, encryption, and diagnostic settings.

## Features

- Fully configurable Virtual Network with all Azure-supported parameters
- Optional inline subnet creation (for simple scenarios)
- DDoS Protection Plan integration
- VNet encryption support (preview feature)
- Diagnostic settings for monitoring
- Flexible naming convention with prefix/suffix support
- `create` flag to enable/disable resource creation

## Dependencies

Before using this module, ensure the following resources exist:

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | The VNet must be created within an existing Resource Group |
| DDoS Protection Plan | No | Only if `ddos_protection_plan` is configured |
| Log Analytics Workspace | No | Only if `diagnostic_settings` requires it |
| Storage Account | No | Only if diagnostic logs need archival |
| Event Hub | No | Only if streaming diagnostics to Event Hub |

## Usage

### Basic Example

```hcl
module "vnet" {
  source = "../../Networking/VirtualNetwork"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"

  name          = "vnet-main-dev-001"
  address_space = ["10.0.0.0/16"]

  tags = {
    Environment = "Development"
    Project     = "MyProject"
  }
}
```

### With Naming Convention

```hcl
module "vnet" {
  source = "../../Networking/VirtualNetwork"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"

  # Uses naming convention: contoso-hub-prod-vnet-001
  name_prefix   = "contoso"
  workload      = "hub"
  environment   = "prod"
  instance      = "001"

  address_space = ["10.0.0.0/16"]
}
```

### With Inline Subnets

```hcl
module "vnet" {
  source = "../../Networking/VirtualNetwork"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"
  name                = "vnet-main-dev-001"
  address_space       = ["10.0.0.0/16"]

  subnets = {
    "snet-frontend" = {
      address_prefixes  = ["10.0.1.0/24"]
      service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
    }
    "snet-backend" = {
      address_prefixes                  = ["10.0.2.0/24"]
      private_endpoint_network_policies = "Enabled"
    }
    "snet-appservice" = {
      address_prefixes = ["10.0.3.0/24"]
      delegation = {
        name = "appservice-delegation"
        service_delegation = {
          name    = "Microsoft.Web/serverFarms"
          actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
    }
  }
}
```

### With DDoS Protection

```hcl
module "vnet" {
  source = "../../Networking/VirtualNetwork"

  resource_group_name = "rg-networking-prod-001"
  location            = "westeurope"
  name                = "vnet-main-prod-001"
  address_space       = ["10.0.0.0/16"]

  ddos_protection_plan = {
    id     = "/subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.Network/ddosProtectionPlans/ddos-plan-001"
    enable = true
  }
}
```

### With Diagnostic Settings

```hcl
module "vnet" {
  source = "../../Networking/VirtualNetwork"

  resource_group_name = "rg-networking-prod-001"
  location            = "westeurope"
  name                = "vnet-main-prod-001"
  address_space       = ["10.0.0.0/16"]

  diagnostic_settings = {
    name                       = "diag-vnet-main"
    log_analytics_workspace_id = "/subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.OperationalInsights/workspaces/law-001"
    log_categories             = ["VMProtectionAlerts"]
    metric_categories          = ["AllMetrics"]
  }
}
```

### Disabled Module (for conditional creation)

```hcl
module "vnet" {
  source = "../../Networking/VirtualNetwork"

  create = false  # Resources will not be created

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"
  address_space       = ["10.0.0.0/16"]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the Virtual Network | `bool` | `true` | no |
| resource_group_name | The name of the Resource Group (DEPENDENCY) | `string` | n/a | **yes** |
| location | The Azure region for deployment (DEPENDENCY) | `string` | n/a | **yes** |
| name | Explicit name for the VNet | `string` | `null` | no |
| name_prefix | Prefix for generated name | `string` | `""` | no |
| name_suffix | Suffix for generated name | `string` | `""` | no |
| workload | Workload name for naming convention | `string` | `"shared"` | no |
| environment | Environment name for naming convention | `string` | `"dev"` | no |
| instance | Instance identifier for naming convention | `string` | `"001"` | no |
| address_space | List of CIDR blocks for the VNet | `list(string)` | n/a | **yes** |
| dns_servers | Custom DNS server IPs | `list(string)` | `[]` | no |
| bgp_community | BGP Community string | `string` | `null` | no |
| edge_zone | Edge Zone name | `string` | `null` | no |
| flow_timeout_in_minutes | Flow timeout (4-30 min) | `number` | `null` | no |
| ddos_protection_plan | DDoS Protection Plan config (DEPENDENCY) | `object({...})` | `null` | no |
| encryption | VNet encryption config | `object({...})` | `null` | no |
| subnets | Map of inline subnets to create | `map(object({...}))` | `{}` | no |
| tags | Tags to assign to resources | `map(string)` | `{}` | no |
| diagnostic_settings | Diagnostic settings config (DEPENDENCY) | `object({...})` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Virtual Network |
| name | The name of the Virtual Network |
| resource_group_name | The Resource Group name |
| location | The Azure region |
| address_space | The address spaces used |
| dns_servers | Configured DNS servers |
| guid | The GUID of the VNet |
| subnet_ids | Map of subnet names to IDs |
| subnet_address_prefixes | Map of subnet names to address prefixes |
| subnets | Map of all subnet attributes |
| diagnostic_settings_id | ID of diagnostic settings (if created) |

## Security Recommendations

1. **Network Segmentation**: Use multiple subnets to segment workloads
2. **NSG Association**: Apply Network Security Groups to all subnets (via separate NSG module)
3. **DDoS Protection**: Enable DDoS Standard for production workloads
4. **Private Endpoints**: Use private endpoints for Azure PaaS services
5. **DNS**: Consider using Azure Private DNS Zones for name resolution
6. **Monitoring**: Enable diagnostic settings to monitor network traffic patterns

## Notes

- For complex subnet configurations with NSG associations, route tables, and service delegations, consider using the dedicated Subnet module
- The `subnets` variable is intended for simple inline subnet creation
- VNet encryption is currently a preview feature
- BGP Community requires ExpressRoute or VPN Gateway configuration

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
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | (Required) The list of address spaces (CIDR blocks) for the Virtual Network.<br/>Example: ["10.0.0.0/16"] or ["10.0.0.0/16", "172.16.0.0/16"] | `list(string)` | n/a | yes |
| <a name="input_bgp_community"></a> [bgp\_community](#input\_bgp\_community) | (Optional) The BGP Community for the Virtual Network. Format: <AS\_number>:<community\_value> | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Virtual Network. Set to false to disable resource creation without removing module code. | `bool` | `true` | no |
| <a name="input_ddos_protection_plan"></a> [ddos\_protection\_plan](#input\_ddos\_protection\_plan) | (Optional) DDoS Protection Plan configuration.<br/>DEPENDENCY: DDoS Protection Plan must exist before referencing its ID.<br/><br/>Attributes:<br/>  - id: The ID of the DDoS Protection Plan to associate.<br/>  - enable: Whether to enable DDoS protection on this VNet. | <pre>object({<br/>    id     = string<br/>    enable = bool<br/>  })</pre> | `null` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | (Optional) Diagnostic settings configuration for the Virtual Network.<br/>DEPENDENCY: Log Analytics Workspace, Storage Account, or Event Hub must exist before referencing.<br/><br/>Attributes:<br/>  - name: Name of the diagnostic setting.<br/>  - log\_analytics\_workspace\_id: Resource ID of the Log Analytics Workspace.<br/>  - storage\_account\_id: Resource ID of the Storage Account for archival.<br/>  - eventhub\_authorization\_rule\_id: Authorization rule ID for Event Hub.<br/>  - eventhub\_name: Name of the Event Hub.<br/>  - log\_categories: List of log categories to enable.<br/>  - metric\_categories: List of metric categories to enable. | <pre>object({<br/>    name                           = optional(string, "diag-vnet")<br/>    log_analytics_workspace_id     = optional(string, null)<br/>    storage_account_id             = optional(string, null)<br/>    eventhub_authorization_rule_id = optional(string, null)<br/>    eventhub_name                  = optional(string, null)<br/>    log_categories                 = optional(list(string), ["VMProtectionAlerts"])<br/>    metric_categories              = optional(list(string), ["AllMetrics"])<br/>  })</pre> | `null` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | (Optional) List of custom DNS server IP addresses. If not set, Azure-provided DNS will be used. | `list(string)` | `[]` | no |
| <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone) | (Optional) The Edge Zone within the Azure Region where this Virtual Network should exist. | `string` | `null` | no |
| <a name="input_encryption"></a> [encryption](#input\_encryption) | (Optional) Virtual Network encryption configuration (preview feature).<br/><br/>Attributes:<br/>  - enforcement: Specifies if encryption is enforced. Possible values: "AllowUnencrypted", "DropUnencrypted". | <pre>object({<br/>    enforcement = string<br/>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) The environment name (e.g., dev, staging, prod), used for naming convention. | `string` | `"dev"` | no |
| <a name="input_flow_timeout_in_minutes"></a> [flow\_timeout\_in\_minutes](#input\_flow\_timeout\_in\_minutes) | (Optional) The flow timeout in minutes for the Virtual Network (4-30 minutes). Requires Standard SKU Load Balancer. | `number` | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number or identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure region where the Virtual Network will be deployed.<br/>DEPENDENCY: Should match the Resource Group location for optimal performance. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The explicit name for the Virtual Network. If provided, overrides name\_prefix/name\_suffix logic. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix to prepend to the generated Virtual Network name. Used when 'name' is not provided. | `string` | `""` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | (Optional) Suffix to append to the generated Virtual Network name. Used when 'name' is not provided. | `string` | `""` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Virtual Network will be created.<br/>DEPENDENCY: Resource Group must exist before creating the VNet. | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | (Optional) Map of inline subnets to create within the Virtual Network.<br/>Note: For complex subnet configurations, consider using the dedicated Subnet module.<br/><br/>Attributes:<br/>  - address\_prefixes: List of address prefixes for the subnet.<br/>  - private\_endpoint\_network\_policies: Enable/disable network policies for private endpoints.<br/>  - private\_link\_service\_network\_policies\_enabled: Enable/disable network policies for private link services.<br/>  - service\_endpoints: List of service endpoints to associate.<br/>  - delegation: Optional service delegation configuration. | <pre>map(object({<br/>    address_prefixes                              = list(string)<br/>    private_endpoint_network_policies             = optional(string, "Disabled")<br/>    private_link_service_network_policies_enabled = optional(bool, false)<br/>    service_endpoints                             = optional(list(string), [])<br/>    delegation = optional(object({<br/>      name = string<br/>      service_delegation = object({<br/>        name    = string<br/>        actions = optional(list(string), [])<br/>      })<br/>    }), null)<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the Virtual Network. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) The workload or application name, used for naming convention. | `string` | `"shared"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_address_space"></a> [address\_space](#output\_address\_space) | The list of address spaces used by the Virtual Network. |
| <a name="output_diagnostic_settings_id"></a> [diagnostic\_settings\_id](#output\_diagnostic\_settings\_id) | The ID of the diagnostic settings (if created). |
| <a name="output_dns_servers"></a> [dns\_servers](#output\_dns\_servers) | The list of DNS servers configured for the Virtual Network. |
| <a name="output_guid"></a> [guid](#output\_guid) | The GUID of the Virtual Network. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Virtual Network. |
| <a name="output_location"></a> [location](#output\_location) | The Azure region where the Virtual Network is deployed. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Virtual Network. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the Resource Group containing the Virtual Network. |
| <a name="output_subnet_address_prefixes"></a> [subnet\_address\_prefixes](#output\_subnet\_address\_prefixes) | Map of subnet names to their address prefixes. |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | Map of subnet names to their IDs. |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | Map of all subnet attributes. |
<!-- END_TF_DOCS -->