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
| [azurerm_machine_learning_workspace_network_outbound_rule_private_endpoint.machine_learning_workspace_network_outbound_rule_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_workspace_network_outbound_rule_private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_machine_learning_workspace_network_outbound_rule_private_endpoint_name"></a> [machine\_learning\_workspace\_network\_outbound\_rule\_private\_endpoint\_name](#input\_machine\_learning\_workspace\_network\_outbound\_rule\_private\_endpoint\_name) | value to set the machine learning workspace outbound rule private endpoint name | `string` | n/a | yes |
| <a name="input_service_resource_id"></a> [service\_resource\_id](#input\_service\_resource\_id) | value to set the service resource id | `string` | n/a | yes |
| <a name="input_spark_enabled"></a> [spark\_enabled](#input\_spark\_enabled) | value to set the spark enabled flag | `bool` | `null` | no |
| <a name="input_sub_resource_target"></a> [sub\_resource\_target](#input\_sub\_resource\_target) | value to set the sub resource target | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | value to set the machine learning workspace id | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT MACHINE LEARNING WORKSPACE NETWORK OUTBOUND RULE PRIVATE ENDPOINT ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->