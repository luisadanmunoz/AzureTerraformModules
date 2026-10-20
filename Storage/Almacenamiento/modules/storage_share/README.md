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
| [azurerm_storage_share.storage_share](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | value to set the access tier | `string` | `null` | no |
| <a name="input_acl"></a> [acl](#input\_acl) | value to set the acl | <pre>list(object({<br/>    id = string<br/>    access_policy = optional(object({<br/>      start       = optional(string)<br/>      expiry      = optional(string)<br/>      permissions = string<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_enabled_protocol"></a> [enabled\_protocol](#input\_enabled\_protocol) | value to set the enabled protocol | `string` | `null` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | value to set the metadata | `map(string)` | `null` | no |
| <a name="input_quota"></a> [quota](#input\_quota) | value to set the quota | `number` | n/a | yes |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | value to set the storage account id | `string` | `null` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | value to set the storage account name | `string` | `null` | no |
| <a name="input_storage_share_name"></a> [storage\_share\_name](#input\_storage\_share\_name) | value to set the storage share name | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT STORAGE SHARE ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_url"></a> [url](#output\_url) | n/a |
<!-- END_TF_DOCS -->