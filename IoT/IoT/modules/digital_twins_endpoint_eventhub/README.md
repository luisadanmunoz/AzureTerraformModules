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
| [azurerm_digital_twins_endpoint_eventhub.digital_twins_endpoint_eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/digital_twins_endpoint_eventhub) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_dead_letter_storage_secret"></a> [dead\_letter\_storage\_secret](#input\_dead\_letter\_storage\_secret) | value to set the dead letter storage secret | `string` | `null` | no |
| <a name="input_digital_twins_endpoint_eventhub_name"></a> [digital\_twins\_endpoint\_eventhub\_name](#input\_digital\_twins\_endpoint\_eventhub\_name) | value to set the digital twins endpoint eventhub name | `string` | n/a | yes |
| <a name="input_digital_twins_id"></a> [digital\_twins\_id](#input\_digital\_twins\_id) | value to set the digital twins id | `string` | n/a | yes |
| <a name="input_eventhub_primary_connection_string"></a> [eventhub\_primary\_connection\_string](#input\_eventhub\_primary\_connection\_string) | value to set the eventhub primary connection string | `string` | n/a | yes |
| <a name="input_eventhub_secondary_connection_string"></a> [eventhub\_secondary\_connection\_string](#input\_eventhub\_secondary\_connection\_string) | value to set the eventhub secondary connection string | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | value of the digital twins endpoint eventhub id |
| <a name="output_name"></a> [name](#output\_name) | value of the digital twins endpoint eventhub name |
<!-- END_TF_DOCS -->