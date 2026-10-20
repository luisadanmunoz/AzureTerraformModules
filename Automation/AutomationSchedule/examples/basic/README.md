<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0, < 5.0.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_schedule_daily"></a> [schedule\_daily](#module\_schedule\_daily) | ../../ | n/a |
| <a name="module_schedule_first_monday"></a> [schedule\_first\_monday](#module\_schedule\_first\_monday) | ../../ | n/a |
| <a name="module_schedule_hourly"></a> [schedule\_hourly](#module\_schedule\_hourly) | ../../ | n/a |
| <a name="module_schedule_weekdays"></a> [schedule\_weekdays](#module\_schedule\_weekdays) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_automation_account.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_account) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_daily_schedule_id"></a> [daily\_schedule\_id](#output\_daily\_schedule\_id) | n/a |
| <a name="output_first_monday_schedule_id"></a> [first\_monday\_schedule\_id](#output\_first\_monday\_schedule\_id) | n/a |
| <a name="output_hourly_schedule_id"></a> [hourly\_schedule\_id](#output\_hourly\_schedule\_id) | n/a |
| <a name="output_weekdays_schedule_id"></a> [weekdays\_schedule\_id](#output\_weekdays\_schedule\_id) | n/a |
<!-- END_TF_DOCS -->