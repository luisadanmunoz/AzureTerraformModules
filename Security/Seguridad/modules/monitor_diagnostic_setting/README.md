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
| [azurerm_monitor_diagnostic_setting.monitor_diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_enabled_logs"></a> [enabled\_logs](#input\_enabled\_logs) | value to set the enabled logs | <pre>list(object({<br/>    category       = optional(string)<br/>    category_group = optional(string)<br/>    retention_policy = optional(object({<br/>      enabled = bool<br/>      days    = optional(number)<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_enabled_metrics"></a> [enabled\_metrics](#input\_enabled\_metrics) | value to set the enabled metrics | <pre>list(object({<br/>    category = string<br/>  }))</pre> | `[]` | no |
| <a name="input_eventhub_authorization_rule_id"></a> [eventhub\_authorization\_rule\_id](#input\_eventhub\_authorization\_rule\_id) | value to set the eventhub authorization rule id | `string` | `null` | no |
| <a name="input_eventhub_name"></a> [eventhub\_name](#input\_eventhub\_name) | value to set the eventhub name | `string` | `null` | no |
| <a name="input_log_analytics_destination_type"></a> [log\_analytics\_destination\_type](#input\_log\_analytics\_destination\_type) | value to set the log analytics destination type | `string` | `null` | no |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | value to set the log analytics workspace id | `string` | `null` | no |
| <a name="input_metrics"></a> [metrics](#input\_metrics) | value to set the metrics | <pre>list(object({<br/>    category = string<br/>    enabled  = optional(bool)<br/>    retention_policy = optional(object({<br/>      enabled = bool<br/>      days    = optional(number)<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_monitor_diagnostic_setting_name"></a> [monitor\_diagnostic\_setting\_name](#input\_monitor\_diagnostic\_setting\_name) | value to set the monitor diagnostic setting name | `string` | n/a | yes |
| <a name="input_partner_solution_id"></a> [partner\_solution\_id](#input\_partner\_solution\_id) | value to set the partner solution id | `string` | `null` | no |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | value to set the storage account id | `string` | `null` | no |
| <a name="input_target_resource_id"></a> [target\_resource\_id](#input\_target\_resource\_id) | value to set the target resource id | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT MONITOR DIAGNOSTIC SETTING ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->