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
| [azurerm_container_app_environment_storage.container_app_environment_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_storage) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_access_key"></a> [access\_key](#input\_access\_key) | value to set the access key | `string` | `null` | no |
| <a name="input_access_mode"></a> [access\_mode](#input\_access\_mode) | value to set the access mode | `string` | n/a | yes |
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | value to set the account name | `string` | `null` | no |
| <a name="input_container_app_environment_id"></a> [container\_app\_environment\_id](#input\_container\_app\_environment\_id) | value to set the container app environment id | `string` | n/a | yes |
| <a name="input_container_app_environment_storage_name"></a> [container\_app\_environment\_storage\_name](#input\_container\_app\_environment\_storage\_name) | value to set the container app environment storage name | `string` | n/a | yes |
| <a name="input_nfs_server_url"></a> [nfs\_server\_url](#input\_nfs\_server\_url) | value to set the nfs server url | `string` | `null` | no |
| <a name="input_share_name"></a> [share\_name](#input\_share\_name) | value to set the share name | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT CONTAINER APP ENVIRONMENT STORAGE ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->