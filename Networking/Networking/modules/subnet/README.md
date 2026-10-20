<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_nat_gateway_association.subnet_nat_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet_network_security_group_association.subnet_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.subnet_route_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_address_prefixes"></a> [address\_prefixes](#input\_address\_prefixes) | value to set the address prefixes | `list(string)` | n/a | yes |
| <a name="input_associate_nat_gateway"></a> [associate\_nat\_gateway](#input\_associate\_nat\_gateway) | value to indicate nat gateway association | `bool` | `false` | no |
| <a name="input_associate_nsg"></a> [associate\_nsg](#input\_associate\_nsg) | value to indicate nsg association | `bool` | `false` | no |
| <a name="input_associate_route_table"></a> [associate\_route\_table](#input\_associate\_route\_table) | value to indicate route table association | `bool` | `false` | no |
| <a name="input_delegations"></a> [delegations](#input\_delegations) | value to set the delegations | <pre>list(object({<br/>    name = string<br/>    service_delegation = object({<br/>      name    = string<br/>      actions = optional(list(string))<br/>    })<br/>  }))</pre> | `[]` | no |
| <a name="input_nat_gateway_id"></a> [nat\_gateway\_id](#input\_nat\_gateway\_id) | value to set the nat gateway id | `string` | `null` | no |
| <a name="input_nsg_id"></a> [nsg\_id](#input\_nsg\_id) | value to set the network security group id | `string` | `null` | no |
| <a name="input_private_endpoint_network_policies"></a> [private\_endpoint\_network\_policies](#input\_private\_endpoint\_network\_policies) | value to set the private endpoint network policies | `string` | `null` | no |
| <a name="input_private_link_service_network_policies"></a> [private\_link\_service\_network\_policies](#input\_private\_link\_service\_network\_policies) | value to set the private link service network policies | `bool` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_route_table_id"></a> [route\_table\_id](#input\_route\_table\_id) | value to set the route table id | `string` | `null` | no |
| <a name="input_service_endpoint_policy_ids"></a> [service\_endpoint\_policy\_ids](#input\_service\_endpoint\_policy\_ids) | value to set the service endpoint policy ids | `list(string)` | `[]` | no |
| <a name="input_service_endpoints"></a> [service\_endpoints](#input\_service\_endpoints) | value to set the service endpoints | `list(string)` | `[]` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | value to set the subnet name | `string` | n/a | yes |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | value to set the virtual network name | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT SUBNET ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->