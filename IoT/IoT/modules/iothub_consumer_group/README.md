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
| [azurerm_iothub_consumer_group.iothub_consumer_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_consumer_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_eventhub_endpoint_name"></a> [eventhub\_endpoint\_name](#input\_eventhub\_endpoint\_name) | value to set the eventhub endpoint name | `string` | n/a | yes |
| <a name="input_iothub_consumer_group_name"></a> [iothub\_consumer\_group\_name](#input\_iothub\_consumer\_group\_name) | value to set the iot hub consumer group name | `string` | n/a | yes |
| <a name="input_iothub_name"></a> [iothub\_name](#input\_iothub\_name) | value to set the iot hub name | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | value of the iot hub consumer group id |
| <a name="output_name"></a> [name](#output\_name) | value of the iot hub consumer group name |
<!-- END_TF_DOCS -->