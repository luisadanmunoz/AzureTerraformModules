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
| [azurerm_machine_learning_workspace_network_outbound_rule_fqdn.machine_learning_workspace_network_outbound_rule_fqdn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_workspace_network_outbound_rule_fqdn) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_destination_fqdn"></a> [destination\_fqdn](#input\_destination\_fqdn) | value to set the destination fqdn | `string` | n/a | yes |
| <a name="input_machine_learning_workspace_network_outbound_rule_fqdn_name"></a> [machine\_learning\_workspace\_network\_outbound\_rule\_fqdn\_name](#input\_machine\_learning\_workspace\_network\_outbound\_rule\_fqdn\_name) | value to set the machine learning workspace outbound rule fqdn name | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | value to set the machine learning workspace id | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT MACHINE LEARNING WORKSPACE NETWORK OUTBOUND RULE FQDN ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->