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
| [azurerm_iothub_fallback_route.iothub_fallback_route](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_fallback_route) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_condition"></a> [condition](#input\_condition) | value to set the condition | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | value to set the enabled flag | `bool` | n/a | yes |
| <a name="input_endpoint_names"></a> [endpoint\_names](#input\_endpoint\_names) | value to set the endpoint names | `list(string)` | n/a | yes |
| <a name="input_fallback_route_source"></a> [fallback\_route\_source](#input\_fallback\_route\_source) | value to set the fallback route source | `string` | `null` | no |
| <a name="input_iothub_name"></a> [iothub\_name](#input\_iothub\_name) | value to set the iot hub name | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | value of the iot hub fallback route id |
<!-- END_TF_DOCS -->