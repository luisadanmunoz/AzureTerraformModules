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
| <a name="module_file_share_smb"></a> [file\_share\_smb](#module\_file\_share\_smb) | ../../ | n/a |

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
| <a name="output_file_share_id"></a> [file\_share\_id](#output\_file\_share\_id) | The ID of the File Share. |
| <a name="output_file_share_name"></a> [file\_share\_name](#output\_file\_share\_name) | The name of the File Share. |
| <a name="output_file_share_resource_manager_id"></a> [file\_share\_resource\_manager\_id](#output\_file\_share\_resource\_manager\_id) | The Resource Manager ID of the File Share. |
| <a name="output_file_share_url"></a> [file\_share\_url](#output\_file\_share\_url) | The URL of the File Share. |
<!-- END_TF_DOCS -->