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
| [azurerm_consumption_budget_management_group.budget_management_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_management_group) | resource |
| [azurerm_consumption_budget_resource_group.budget_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_resource_group) | resource |
| [azurerm_consumption_budget_subscription.budget_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_amount"></a> [amount](#input\_amount) | value to set the amount | `number` | n/a | yes |
| <a name="input_budget_name"></a> [budget\_name](#input\_budget\_name) | value to set the budget name | `string` | n/a | yes |
| <a name="input_end_date"></a> [end\_date](#input\_end\_date) | value to set the end date | `string` | `null` | no |
| <a name="input_management_group_id"></a> [management\_group\_id](#input\_management\_group\_id) | value to set the management group id | `string` | `null` | no |
| <a name="input_notifications"></a> [notifications](#input\_notifications) | value to set the notifications | <pre>map(object({<br/>    enabled        = bool<br/>    operator       = string<br/>    threshold      = number<br/>    threshold_type = optional(string)<br/>    contact_emails = optional(list(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | value to set the resource group id | `string` | `null` | no |
| <a name="input_scope_type"></a> [scope\_type](#input\_scope\_type) | value to set the scope type | `string` | n/a | yes |
| <a name="input_start_date"></a> [start\_date](#input\_start\_date) | value to set the start date | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | value to set the subscription id | `string` | `null` | no |
| <a name="input_time_grain"></a> [time\_grain](#input\_time\_grain) | value to set the time grain | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT BUDGET ############################################################################ |
<!-- END_TF_DOCS -->