# Azure Virtual WAN Terraform Module

This module creates an Azure Virtual WAN with support for Virtual Hubs, VPN Gateways, VPN Sites, and ExpressRoute Gateways.

## Features

- Virtual WAN with Standard or Basic SKU
- Multiple Virtual Hubs across different regions
- VPN Gateways with BGP settings and scale units
- VPN Sites with multi-link support
- ExpressRoute Gateways with auto-scale
- Office 365 local breakout configuration
- Branch-to-branch traffic control

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist |

## Usage

### Basic Virtual WAN with a Hub

```hcl
module "virtual_wan" {
  source = "../../Networking/VirtualWAN"

  resource_group_name = "rg-vwan-prod-001"
  location            = "westeurope"

  name = "vwan-hub-prod-001"
  type = "Standard"

  virtual_hubs = [
    {
      name           = "vhub-westeurope-prod-001"
      location       = "westeurope"
      address_prefix = "10.0.0.0/23"
    }
  ]
}
```

### Virtual WAN with VPN Gateway and Site

```hcl
module "virtual_wan" {
  source = "../../Networking/VirtualWAN"

  resource_group_name = "rg-vwan-prod-001"
  location            = "westeurope"

  name = "vwan-hub-prod-001"
  type = "Standard"

  virtual_hubs = [
    {
      name           = "vhub-westeurope-prod-001"
      location       = "westeurope"
      address_prefix = "10.0.0.0/23"
    }
  ]

  vpn_gateways = [
    {
      name            = "vpngw-westeurope-prod-001"
      virtual_hub_key = 0
      scale_unit      = 1
    }
  ]

  vpn_sites = [
    {
      name          = "site-branch-office-001"
      address_cidrs = ["192.168.1.0/24"]
      device_vendor = "Cisco"
      links = [
        {
          name       = "link-primary"
          ip_address = "203.0.113.1"
        }
      ]
    }
  ]
}
```

### Virtual WAN with ExpressRoute Gateway

```hcl
module "virtual_wan" {
  source = "../../Networking/VirtualWAN"

  resource_group_name = "rg-vwan-prod-001"
  location            = "westeurope"

  name = "vwan-hub-prod-001"
  type = "Standard"

  virtual_hubs = [
    {
      name           = "vhub-westeurope-prod-001"
      location       = "westeurope"
      address_prefix = "10.0.0.0/23"
    }
  ]

  er_gateways = [
    {
      name            = "ergw-westeurope-prod-001"
      virtual_hub_key = 0
      scale_unit      = 1
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls resource creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| name | Virtual WAN name | `string` | auto | no |
| name_prefix | Prefix for generated name | `string` | `"vwan"` | no |
| workload | Workload name | `string` | `"hub"` | no |
| environment | Environment name | `string` | `"prod"` | no |
| instance | Instance identifier | `string` | `"001"` | no |
| disable_vpn_encryption | Disable VPN encryption | `bool` | `false` | no |
| allow_branch_to_branch_traffic | Allow branch-to-branch traffic | `bool` | `true` | no |
| office365_local_breakout_category | O365 breakout category | `string` | `"None"` | no |
| type | Basic or Standard | `string` | `"Standard"` | no |
| virtual_hubs | List of Virtual Hubs | `list(object({...}))` | `[]` | no |
| vpn_gateways | List of VPN Gateways | `list(object({...}))` | `[]` | no |
| vpn_sites | List of VPN Sites | `list(object({...}))` | `[]` | no |
| er_gateways | List of ExpressRoute Gateways | `list(object({...}))` | `[]` | no |
| tags | Tags to assign | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Virtual WAN ID |
| name | Virtual WAN name |
| virtual_hub_ids | Map of Virtual Hub IDs keyed by index |
| vpn_gateway_ids | Map of VPN Gateway IDs keyed by index |

## Notes

- Virtual Hub deployment can take 10-30 minutes
- VPN Gateway and ExpressRoute Gateway deployments can take 20-30 minutes each
- Standard SKU is required for VPN Gateways and ExpressRoute Gateways
- Virtual Hubs must have unique address prefixes that do not overlap
- Branch-to-branch traffic requires Standard SKU
