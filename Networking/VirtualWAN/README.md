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
| [azurerm_express_route_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_gateway) | resource |
| [azurerm_virtual_hub.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub) | resource |
| [azurerm_virtual_wan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_wan) | resource |
| [azurerm_vpn_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/vpn_gateway) | resource |
| [azurerm_vpn_site.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/vpn_site) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allow_branch_to_branch_traffic"></a> [allow\_branch\_to\_branch\_traffic](#input\_allow\_branch\_to\_branch\_traffic) | (Optional) Allow branch-to-branch traffic flow. | `bool` | `true` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Virtual WAN and associated resources. | `bool` | `true` | no |
| <a name="input_disable_vpn_encryption"></a> [disable\_vpn\_encryption](#input\_disable\_vpn\_encryption) | (Optional) Disable VPN encryption for the Virtual WAN. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name. | `string` | `"prod"` | no |
| <a name="input_er_gateways"></a> [er\_gateways](#input\_er\_gateways) | (Optional) List of ExpressRoute Gateways to create within Virtual Hubs.<br/><br/>Attributes:<br/>  - name:                          (Required) Name of the ExpressRoute Gateway.<br/>  - virtual\_hub\_key:               (Required) Index key of the Virtual Hub from the virtual\_hubs list.<br/>  - scale\_unit:                    (Required) Scale unit for the ExpressRoute Gateway.<br/>  - allow\_non\_virtual\_wan\_traffic: (Optional) Allow non-Virtual-WAN traffic. Defaults to false. | <pre>list(object({<br/>    name                          = string<br/>    virtual_hub_key               = number<br/>    scale_unit                    = number<br/>    allow_non_virtual_wan_traffic = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance identifier. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Azure region. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Explicit name for the Virtual WAN. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for generated name. | `string` | `"vwan"` | no |
| <a name="input_office365_local_breakout_category"></a> [office365\_local\_breakout\_category](#input\_office365\_local\_breakout\_category) | (Optional) Office 365 local breakout category. Valid values: None, Optimize, OptimizeAndAllow, All. | `string` | `"None"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource Group name. DEPENDENCY: Must exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | (Optional) Virtual WAN type. Valid values: Basic, Standard. | `string` | `"Standard"` | no |
| <a name="input_virtual_hubs"></a> [virtual\_hubs](#input\_virtual\_hubs) | (Optional) List of Virtual Hubs to create within the Virtual WAN.<br/><br/>Attributes:<br/>  - name:                                     (Required) Name of the Virtual Hub.<br/>  - location:                                 (Required) Azure region for the Virtual Hub.<br/>  - address\_prefix:                           (Required) Address prefix for the Virtual Hub (e.g., "10.0.0.0/23").<br/>  - sku:                                      (Optional) SKU of the Virtual Hub. Defaults to "Standard".<br/>  - hub\_routing\_preference:                   (Optional) Routing preference. Valid values: ExpressRoute, ASPath, VpnGateway.<br/>  - virtual\_router\_auto\_scale\_min\_capacity:   (Optional) Minimum number of scale units for Virtual Router auto scale. | <pre>list(object({<br/>    name                                   = string<br/>    location                               = string<br/>    address_prefix                         = string<br/>    sku                                    = optional(string, "Standard")<br/>    hub_routing_preference                 = optional(string, null)<br/>    virtual_router_auto_scale_min_capacity = optional(number, null)<br/>  }))</pre> | `[]` | no |
| <a name="input_vpn_gateways"></a> [vpn\_gateways](#input\_vpn\_gateways) | (Optional) List of VPN Gateways to create within Virtual Hubs.<br/><br/>Attributes:<br/>  - name:                                    (Required) Name of the VPN Gateway.<br/>  - virtual\_hub\_key:                         (Required) Index key of the Virtual Hub from the virtual\_hubs list.<br/>  - bgp\_route\_translation\_for\_nat\_enabled:   (Optional) Enable BGP route translation for NAT.<br/>  - bgp\_settings:                            (Optional) BGP settings configuration.<br/>  - routing\_preference:                      (Optional) Azure routing preference. Valid values: Microsoft Network, Internet.<br/>  - scale\_unit:                              (Optional) Scale unit for the VPN Gateway. Defaults to 1. | <pre>list(object({<br/>    name                                  = string<br/>    virtual_hub_key                       = number<br/>    bgp_route_translation_for_nat_enabled = optional(bool, false)<br/>    bgp_settings = optional(object({<br/>      asn         = number<br/>      peer_weight = number<br/>      instance_0_bgp_peering_address = optional(object({<br/>        custom_ips = list(string)<br/>      }), null)<br/>      instance_1_bgp_peering_address = optional(object({<br/>        custom_ips = list(string)<br/>      }), null)<br/>    }), null)<br/>    routing_preference = optional(string, null)<br/>    scale_unit         = optional(number, 1)<br/>  }))</pre> | `[]` | no |
| <a name="input_vpn_sites"></a> [vpn\_sites](#input\_vpn\_sites) | (Optional) List of VPN Sites to create for the Virtual WAN.<br/><br/>Attributes:<br/>  - name:            (Required) Name of the VPN Site.<br/>  - address\_cidrs:   (Optional) List of address CIDRs for the VPN Site.<br/>  - device\_model:    (Optional) Model of the VPN device.<br/>  - device\_vendor:   (Optional) Vendor of the VPN device.<br/>  - links:           (Optional) List of VPN Site Links. | <pre>list(object({<br/>    name          = string<br/>    address_cidrs = optional(list(string), null)<br/>    device_model  = optional(string, null)<br/>    device_vendor = optional(string, null)<br/>    links = optional(list(object({<br/>      name          = string<br/>      ip_address    = optional(string, null)<br/>      fqdn          = optional(string, null)<br/>      provider_name = optional(string, null)<br/>      speed_in_mbps = optional(number, 0)<br/>      bgp = optional(object({<br/>        asn             = number<br/>        peering_address = string<br/>      }), null)<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name. | `string` | `"hub"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Virtual WAN. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Virtual WAN. |
| <a name="output_virtual_hub_ids"></a> [virtual\_hub\_ids](#output\_virtual\_hub\_ids) | Map of Virtual Hub IDs keyed by index. |
| <a name="output_vpn_gateway_ids"></a> [vpn\_gateway\_ids](#output\_vpn\_gateway\_ids) | Map of VPN Gateway IDs keyed by index. |
<!-- END_TF_DOCS -->