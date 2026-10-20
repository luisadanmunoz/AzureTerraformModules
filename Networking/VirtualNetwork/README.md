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
