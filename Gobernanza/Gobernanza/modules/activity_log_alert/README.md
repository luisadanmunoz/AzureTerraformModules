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
| [azurerm_monitor_activity_log_alert.activity_log_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_activity_log_alert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_action_group_ids"></a> [action\_group\_ids](#input\_action\_group\_ids) | value to set the action group ids | `list(string)` | `[]` | no |
| <a name="input_activity_log_alert_name"></a> [activity\_log\_alert\_name](#input\_activity\_log\_alert\_name) | value to set the activity log alert name | `string` | n/a | yes |
| <a name="input_category"></a> [category](#input\_category) | value to set the category | `string` | `"Administrative"` | no |
| <a name="input_description"></a> [description](#input\_description) | value to set the description | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | value to set the enabled flag | `bool` | `true` | no |
| <a name="input_level"></a> [level](#input\_level) | value to set the level | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_operation_name"></a> [operation\_name](#input\_operation\_name) | value to set the operation name | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_scopes"></a> [scopes](#input\_scopes) | value to set the scopes | `list(string)` | n/a | yes |
| <a name="input_status"></a> [status](#input\_status) | value to set the status | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT ACTIVITY LOG ALERT ############################################################################ |
<!-- END_TF_DOCS -->