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
