# Azure Route Server Terraform Module

This module creates an Azure Route Server with optional Public IP creation and BGP connection configuration.

## Features

- Automatic Public IP creation (or bring your own)
- Branch-to-branch traffic control
- BGP connection (peering) management with NVAs
- Flexible naming convention
- Standard SKU support

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist before creating the Route Server |
| Virtual Network | **Yes** | Must contain a subnet named `RouteServerSubnet` |
| RouteServerSubnet | **Yes** | Subnet named exactly `RouteServerSubnet` with a minimum /27 prefix |
| Public IP | No | If providing an existing Public IP (must be Standard SKU, Static allocation) |

## Usage

### Basic Example (Auto-creates Public IP)

```hcl
module "route_server" {
  source = "../../Networking/RouteServer"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"
  subnet_id           = azurerm_subnet.route_server.id

  name = "rs-hub-dev-001"
}
```

### With BGP Connections

```hcl
module "route_server" {
  source = "../../Networking/RouteServer"

  resource_group_name = "rg-networking-prod-001"
  location            = "westeurope"
  subnet_id           = azurerm_subnet.route_server.id

  name                             = "rs-hub-prod-001"
  branch_to_branch_traffic_enabled = true

  bgp_connections = [
    {
      name     = "nva-primary"
      peer_asn = 65001
      peer_ip  = "10.0.1.4"
    },
    {
      name     = "nva-secondary"
      peer_asn = 65001
      peer_ip  = "10.0.1.5"
    }
  ]
}
```

### With Existing Public IP

```hcl
module "route_server" {
  source = "../../Networking/RouteServer"

  resource_group_name  = "rg-networking-prod-001"
  location             = "westeurope"
  subnet_id            = azurerm_subnet.route_server.id
  public_ip_address_id = azurerm_public_ip.route_server.id

  name = "rs-hub-prod-001"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls resource creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| name | Explicit name | `string` | `null` | no |
| name_prefix | Prefix for generated name | `string` | `"rs"` | no |
| name_suffix | Suffix for generated name | `string` | `""` | no |
| workload | Workload name | `string` | `"default"` | no |
| environment | Environment name | `string` | `"dev"` | no |
| instance | Instance identifier | `string` | `"001"` | no |
| sku | SKU (Standard only) | `string` | `"Standard"` | no |
| subnet_id | RouteServerSubnet ID | `string` | n/a | **yes** |
| public_ip_address_id | Existing Public IP ID | `string` | `null` | no |
| branch_to_branch_traffic_enabled | Enable branch-to-branch | `bool` | `false` | no |
| bgp_connections | BGP peering connections | `list(object)` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Route Server |
| name | The name of the Route Server |
| virtual_router_asn | The ASN of the virtual router |
| virtual_router_ips | The BGP peering IP addresses of the virtual router |
| public_ip_id | Created Public IP ID (if created by module) |
| public_ip_address | Created Public IP address (if created by module) |

## Notes

- The Route Server must be deployed into a subnet named exactly `RouteServerSubnet`
- The `RouteServerSubnet` requires a minimum prefix of /27
- Route Server uses ASN 65515 by default (assigned by Azure, not configurable)
- Each Route Server supports up to 8 BGP connections
- Branch-to-branch traffic enables transit between VPN/ExpressRoute gateways via Route Server

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
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_route_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_server) | resource |
| [azurerm_route_server_bgp_connection.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_server_bgp_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_bgp_connections"></a> [bgp\_connections](#input\_bgp\_connections) | (Optional) A list of BGP connections (peerings) to configure on the Route Server.<br/>Each object requires:<br/>  - name:     The name of the BGP connection.<br/>  - peer\_asn: The ASN of the BGP peer (NVA).<br/>  - peer\_ip:  The IP address of the BGP peer (NVA). | <pre>list(object({<br/>    name     = string<br/>    peer_asn = number<br/>    peer_ip  = string<br/>  }))</pre> | `[]` | no |
| <a name="input_branch_to_branch_traffic_enabled"></a> [branch\_to\_branch\_traffic\_enabled](#input\_branch\_to\_branch\_traffic\_enabled) | (Optional) Whether to enable branch-to-branch traffic for the Route Server. | `bool` | `false` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Route Server. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name. | `string` | `"dev"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance identifier. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure region where the Route Server will be deployed.<br/>DEPENDENCY: Should match the Resource Group location. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The explicit name for the Route Server. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for generated name. | `string` | `"rs"` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | (Optional) Suffix for generated name. | `string` | `""` | no |
| <a name="input_public_ip_address_id"></a> [public\_ip\_address\_id](#input\_public\_ip\_address\_id) | (Optional) The ID of an existing Public IP to associate with the Route Server.<br/>If null, the module will create a new Standard SKU Public IP automatically.<br/>DEPENDENCY: If provided, the Public IP must exist and be Standard SKU with Static allocation. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Route Server will be created.<br/>DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | (Optional) The SKU of the Route Server. Only 'Standard' is supported. | `string` | `"Standard"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required) The ID of the subnet where the Route Server will be deployed.<br/>The subnet must be named 'RouteServerSubnet'.<br/>DEPENDENCY: Subnet named 'RouteServerSubnet' must exist in the target Virtual Network. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for naming convention. | `string` | `"default"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Route Server. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Route Server. |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The IP address of the created Public IP (if created by the module). |
| <a name="output_public_ip_id"></a> [public\_ip\_id](#output\_public\_ip\_id) | The ID of the created Public IP (if created by the module). |
| <a name="output_virtual_router_asn"></a> [virtual\_router\_asn](#output\_virtual\_router\_asn) | The ASN of the Route Server virtual router. |
| <a name="output_virtual_router_ips"></a> [virtual\_router\_ips](#output\_virtual\_router\_ips) | The IP addresses of the Route Server virtual router (BGP peering endpoints). |
<!-- END_TF_DOCS -->