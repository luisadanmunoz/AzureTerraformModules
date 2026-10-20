<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_datalake_filesystem"></a> [datalake\_filesystem](#module\_datalake\_filesystem) | ../../ | n/a |

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
| <a name="output_filesystem_id"></a> [filesystem\_id](#output\_filesystem\_id) | The ID of the Data Lake Gen2 Filesystem. |
| <a name="output_filesystem_name"></a> [filesystem\_name](#output\_filesystem\_name) | The name of the Data Lake Gen2 Filesystem. |
| <a name="output_path_ids"></a> [path\_ids](#output\_path\_ids) | Map of directory path keys to their resource IDs. |
<!-- END_TF_DOCS -->