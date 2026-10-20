<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_keyvault_dev"></a> [keyvault\_dev](#module\_keyvault\_dev) | ../../ | n/a |
| <a name="module_keyvault_prod"></a> [keyvault\_prod](#module\_keyvault\_prod) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.kv_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_subnet.app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_dev_keyvault_id"></a> [dev\_keyvault\_id](#output\_dev\_keyvault\_id) | n/a |
| <a name="output_dev_keyvault_uri"></a> [dev\_keyvault\_uri](#output\_dev\_keyvault\_uri) | n/a |
| <a name="output_prod_keyvault_id"></a> [prod\_keyvault\_id](#output\_prod\_keyvault\_id) | n/a |
| <a name="output_prod_keyvault_uri"></a> [prod\_keyvault\_uri](#output\_prod\_keyvault\_uri) | n/a |
<!-- END_TF_DOCS -->