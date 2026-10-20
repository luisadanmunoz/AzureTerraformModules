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
| [azurerm_digital_twins_endpoint_eventgrid.digital_twins_endpoint_eventgrid](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/digital_twins_endpoint_eventgrid) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_dead_letter_storage_secret"></a> [dead\_letter\_storage\_secret](#input\_dead\_letter\_storage\_secret) | value to set the dead letter storage secret | `string` | `null` | no |
| <a name="input_digital_twins_endpoint_eventgrid_name"></a> [digital\_twins\_endpoint\_eventgrid\_name](#input\_digital\_twins\_endpoint\_eventgrid\_name) | value to set the digital twins endpoint eventgrid name | `string` | n/a | yes |
| <a name="input_digital_twins_id"></a> [digital\_twins\_id](#input\_digital\_twins\_id) | value to set the digital twins id | `string` | n/a | yes |
| <a name="input_eventgrid_topic_endpoint"></a> [eventgrid\_topic\_endpoint](#input\_eventgrid\_topic\_endpoint) | value to set the eventgrid topic endpoint | `string` | n/a | yes |
| <a name="input_eventgrid_topic_primary_access_key"></a> [eventgrid\_topic\_primary\_access\_key](#input\_eventgrid\_topic\_primary\_access\_key) | value to set the eventgrid topic primary access key | `string` | n/a | yes |
| <a name="input_eventgrid_topic_secondary_access_key"></a> [eventgrid\_topic\_secondary\_access\_key](#input\_eventgrid\_topic\_secondary\_access\_key) | value to set the eventgrid topic secondary access key | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | value of the digital twins endpoint eventgrid id |
| <a name="output_name"></a> [name](#output\_name) | value of the digital twins endpoint eventgrid name |
<!-- END_TF_DOCS -->