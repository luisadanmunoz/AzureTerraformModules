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
| [azurerm_iothub_device_update_account.iothub_device_update_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_device_update_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_identity"></a> [identity](#input\_identity) | value to set the identity | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_iothub_device_update_account_name"></a> [iothub\_device\_update\_account\_name](#input\_iothub\_device\_update\_account\_name) | value to set the iot hub device update account name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | value to set the public network access enabled flag | `bool` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | value to set the sku | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_host_name"></a> [host\_name](#output\_host\_name) | value of the iot hub device update account host name |
| <a name="output_id"></a> [id](#output\_id) | value of the iot hub device update account id |
| <a name="output_name"></a> [name](#output\_name) | value of the iot hub device update account name |
<!-- END_TF_DOCS -->