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
| <a name="module_storage_table_basic"></a> [storage\_table\_basic](#module\_storage\_table\_basic) | ../../ | n/a |
| <a name="module_storage_table_with_acl"></a> [storage\_table\_with\_acl](#module\_storage\_table\_with\_acl) | ../../ | n/a |
| <a name="module_storage_tables_multiple"></a> [storage\_tables\_multiple](#module\_storage\_tables\_multiple) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_acl_table_id"></a> [acl\_table\_id](#output\_acl\_table\_id) | ID of the storage table with ACL |
| <a name="output_multiple_table_ids"></a> [multiple\_table\_ids](#output\_multiple\_table\_ids) | IDs of the multiple storage tables |
| <a name="output_multiple_table_names"></a> [multiple\_table\_names](#output\_multiple\_table\_names) | Names of the multiple storage tables |
| <a name="output_single_table_id"></a> [single\_table\_id](#output\_single\_table\_id) | ID of the basic single storage table |
| <a name="output_single_table_name"></a> [single\_table\_name](#output\_single\_table\_name) | Name of the basic single storage table |
<!-- END_TF_DOCS -->