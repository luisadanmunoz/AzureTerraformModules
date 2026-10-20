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
| [azurerm_machine_learning_workspace_network_outbound_rule_service_tag.machine_learning_workspace_network_outbound_rule_service_tag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_workspace_network_outbound_rule_service_tag) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_machine_learning_workspace_network_outbound_rule_service_tag_name"></a> [machine\_learning\_workspace\_network\_outbound\_rule\_service\_tag\_name](#input\_machine\_learning\_workspace\_network\_outbound\_rule\_service\_tag\_name) | value to set the machine learning workspace outbound rule service tag name | `string` | n/a | yes |
| <a name="input_port_ranges"></a> [port\_ranges](#input\_port\_ranges) | value to set the port ranges | `string` | n/a | yes |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | value to set the protocol | `string` | n/a | yes |
| <a name="input_service_tag"></a> [service\_tag](#input\_service\_tag) | value to set the service tag | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | value to set the machine learning workspace id | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT MACHINE LEARNING WORKSPACE NETWORK OUTBOUND RULE SERVICE TAG ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->