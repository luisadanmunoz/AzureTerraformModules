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
| [azurerm_iothub_file_upload.iothub_file_upload](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_file_upload) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_authentication_type"></a> [authentication\_type](#input\_authentication\_type) | value to set the authentication type | `string` | `null` | no |
| <a name="input_connection_string"></a> [connection\_string](#input\_connection\_string) | value to set the connection string | `string` | n/a | yes |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | value to set the container name | `string` | n/a | yes |
| <a name="input_default_ttl"></a> [default\_ttl](#input\_default\_ttl) | value to set the default ttl | `string` | `null` | no |
| <a name="input_identity_id"></a> [identity\_id](#input\_identity\_id) | value to set the identity id | `string` | `null` | no |
| <a name="input_iothub_id"></a> [iothub\_id](#input\_iothub\_id) | value to set the iot hub id | `string` | n/a | yes |
| <a name="input_lock_duration"></a> [lock\_duration](#input\_lock\_duration) | value to set the lock duration | `string` | `null` | no |
| <a name="input_max_delivery_count"></a> [max\_delivery\_count](#input\_max\_delivery\_count) | value to set the max delivery count | `number` | `null` | no |
| <a name="input_notifications_enabled"></a> [notifications\_enabled](#input\_notifications\_enabled) | value to set the notifications enabled flag | `bool` | `null` | no |
| <a name="input_sas_ttl"></a> [sas\_ttl](#input\_sas\_ttl) | value to set the sas ttl | `string` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | value of the iot hub file upload id |
<!-- END_TF_DOCS -->