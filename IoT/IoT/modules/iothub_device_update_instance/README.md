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
| [azurerm_iothub_device_update_instance.iothub_device_update_instance](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_device_update_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_device_update_account_id"></a> [device\_update\_account\_id](#input\_device\_update\_account\_id) | value to set the device update account id | `string` | n/a | yes |
| <a name="input_diagnostic_enabled"></a> [diagnostic\_enabled](#input\_diagnostic\_enabled) | value to set the diagnostic enabled flag | `bool` | `null` | no |
| <a name="input_diagnostic_storage_account"></a> [diagnostic\_storage\_account](#input\_diagnostic\_storage\_account) | value to set the diagnostic storage account | <pre>object({<br/>    connection_string = string<br/>    id                = string<br/>  })</pre> | `null` | no |
| <a name="input_iothub_device_update_instance_name"></a> [iothub\_device\_update\_instance\_name](#input\_iothub\_device\_update\_instance\_name) | value to set the iot hub device update instance name | `string` | n/a | yes |
| <a name="input_iothub_id"></a> [iothub\_id](#input\_iothub\_id) | value to set the iot hub id | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | value of the iot hub device update instance id |
| <a name="output_name"></a> [name](#output\_name) | value of the iot hub device update instance name |
<!-- END_TF_DOCS -->