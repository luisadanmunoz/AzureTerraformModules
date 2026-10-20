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

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_route_server"></a> [route\_server](#module\_route\_server) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.route_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_route_server_id"></a> [route\_server\_id](#output\_route\_server\_id) | n/a |
| <a name="output_route_server_name"></a> [route\_server\_name](#output\_route\_server\_name) | n/a |
| <a name="output_virtual_router_asn"></a> [virtual\_router\_asn](#output\_virtual\_router\_asn) | n/a |
| <a name="output_virtual_router_ips"></a> [virtual\_router\_ips](#output\_virtual\_router\_ips) | n/a |
<!-- END_TF_DOCS -->