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
| <a name="module_subnet_basic"></a> [subnet\_basic](#module\_subnet\_basic) | ../../ | n/a |
| <a name="module_subnet_delegated"></a> [subnet\_delegated](#module\_subnet\_delegated) | ../../ | n/a |
| <a name="module_subnet_with_endpoints"></a> [subnet\_with\_endpoints](#module\_subnet\_with\_endpoints) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_virtual_network.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_subnet_basic_id"></a> [subnet\_basic\_id](#output\_subnet\_basic\_id) | ID of the basic subnet |
| <a name="output_subnet_delegated_id"></a> [subnet\_delegated\_id](#output\_subnet\_delegated\_id) | ID of the delegated subnet |
| <a name="output_subnet_with_endpoints_id"></a> [subnet\_with\_endpoints\_id](#output\_subnet\_with\_endpoints\_id) | ID of the subnet with service endpoints |
<!-- END_TF_DOCS -->