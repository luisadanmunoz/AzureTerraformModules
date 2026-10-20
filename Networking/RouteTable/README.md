# Azure Route Table Terraform Module

This module creates an Azure Route Table with configurable routes for custom routing scenarios.

## Features

- Custom routes with various next hop types
- BGP route propagation control
- Virtual Appliance (NVA/Firewall) routing support
- Flexible naming convention
- `create` flag for conditional creation

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist before creating the Route Table |
| Network Virtual Appliance | No | Only if using VirtualAppliance next hop type |
| Azure Firewall | No | Only if routing traffic through Azure Firewall |

## Usage

### Basic Example

```hcl
module "route_table" {
  source = "../../Networking/RouteTable"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"

  name = "rt-spoke-dev-001"
}
```

### Force Traffic Through Firewall

```hcl
module "route_table" {
  source = "../../Networking/RouteTable"

  resource_group_name = "rg-networking-prod-001"
  location            = "westeurope"

  name                          = "rt-spoke-prod-001"
  bgp_route_propagation_enabled = false

  routes = {
    "to-internet" = {
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.0.0.4"  # Azure Firewall private IP
    }
    "to-onprem" = {
      address_prefix         = "192.168.0.0/16"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.0.0.4"
    }
  }
}
```

### Block Internet Access

```hcl
module "route_table" {
  source = "../../Networking/RouteTable"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"
  name                = "rt-isolated-dev-001"

  routes = {
    "block-internet" = {
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "None"
    }
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls resource creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| name | Explicit name | `string` | `null` | no |
| bgp_route_propagation_enabled | Enable BGP propagation | `bool` | `true` | no |
| routes | Map of routes | `map(object({...}))` | `{}` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Route Table |
| name | The name of the Route Table |
| route_ids | Map of route names to IDs |
| routes | Map of route configurations |

## Next Hop Types

| Type | Description |
|------|-------------|
| `VirtualNetworkGateway` | Route to VPN/ExpressRoute Gateway |
| `VnetLocal` | Route within the VNet |
| `Internet` | Route to Internet |
| `VirtualAppliance` | Route to NVA/Firewall (requires IP) |
| `None` | Drop traffic (blackhole) |

## Security Recommendations

1. **Disable BGP propagation** when using forced tunneling
2. **Use Azure Firewall** or NVA for internet-bound traffic inspection
3. **Document all routes** for compliance and troubleshooting

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
| [azurerm_route.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route) | resource |
| [azurerm_route_table.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_bgp_route_propagation_enabled"></a> [bgp\_route\_propagation\_enabled](#input\_bgp\_route\_propagation\_enabled) | (Optional) Enable or disable BGP route propagation.<br/>Set to false to prevent learned routes from being added to the route table.<br/>Default is true. | `bool` | `true` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Route Table. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance identifier. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure region where the Route Table will be deployed.<br/>DEPENDENCY: Should match the Resource Group location. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The explicit name for the Route Table. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for generated name. | `string` | `"rt"` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | (Optional) Suffix for generated name. | `string` | `""` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Route Table will be created.<br/>DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_routes"></a> [routes](#input\_routes) | (Optional) Map of routes to create in the Route Table.<br/><br/>Attributes:<br/>  - address\_prefix: The destination CIDR (e.g., "0.0.0.0/0", "10.0.0.0/8").<br/>  - next\_hop\_type: The type of next hop. Possible values:<br/>    - "VirtualNetworkGateway"<br/>    - "VnetLocal"<br/>    - "Internet"<br/>    - "VirtualAppliance"<br/>    - "None"<br/>  - next\_hop\_in\_ip\_address: The IP address of the next hop (required for VirtualAppliance).<br/>    DEPENDENCY: The NVA/Firewall must exist and be reachable. | <pre>map(object({<br/>    address_prefix         = string<br/>    next_hop_type          = string<br/>    next_hop_in_ip_address = optional(string, null)<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the Route Table. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for naming convention. | `string` | `"default"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Route Table. |
| <a name="output_location"></a> [location](#output\_location) | The Azure region. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Route Table. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the Resource Group. |
| <a name="output_route_ids"></a> [route\_ids](#output\_route\_ids) | Map of route names to their IDs. |
| <a name="output_routes"></a> [routes](#output\_routes) | Map of route configurations. |
<!-- END_TF_DOCS -->