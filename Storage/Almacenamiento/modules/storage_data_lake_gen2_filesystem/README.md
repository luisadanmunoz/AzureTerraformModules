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
| [azurerm_storage_data_lake_gen2_filesystem.storage_data_lake_gen2_filesystem](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_data_lake_gen2_filesystem) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_ace"></a> [ace](#input\_ace) | value to set the ace | <pre>list(object({<br/>    id          = optional(string)<br/>    permissions = string<br/>    scope       = optional(string)<br/>    type        = string<br/>  }))</pre> | `[]` | no |
| <a name="input_default_encryption_scope"></a> [default\_encryption\_scope](#input\_default\_encryption\_scope) | value to set the default encryption scope | `string` | `null` | no |
| <a name="input_properties"></a> [properties](#input\_properties) | value to set the properties | `map(string)` | `null` | no |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | value to set the storage account id | `string` | n/a | yes |
| <a name="input_storage_data_lake_gen2_filesystem_name"></a> [storage\_data\_lake\_gen2\_filesystem\_name](#input\_storage\_data\_lake\_gen2\_filesystem\_name) | value to set the storage data lake gen2 filesystem name | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT STORAGE DATA LAKE GEN2 FILESYSTEM ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->