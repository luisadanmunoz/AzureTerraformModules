# Azure Automation Schedule Module

Terraform module to create and manage **Azure Automation Schedules** for automated runbook execution with support for one-time, hourly, daily, weekly, and monthly frequencies.

## Features

- All frequency types: OneTime, Hour, Day, Week, Month
- Weekly schedules with specific days
- Monthly schedules by day of month or week occurrence
- Timezone support
- Expiry time configuration
- Input validation for all parameters
- Conditional creation with `create = true/false`

## Usage - One-Time Schedule

```hcl
module "schedule_onetime" {
  source = "path/to/Automation/AutomationSchedule"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"
  name                    = "maintenance-window"
  description             = "One-time maintenance task"

  frequency  = "OneTime"
  start_time = "2024-12-01T02:00:00+00:00"
  timezone   = "UTC"
}
```

## Usage - Hourly Schedule

```hcl
module "schedule_hourly" {
  source = "path/to/Automation/AutomationSchedule"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"
  name                    = "health-check-hourly"
  description             = "Run health checks every 2 hours"

  frequency  = "Hour"
  interval   = 2
  start_time = "2024-01-01T00:00:00+00:00"
  timezone   = "UTC"
}
```

## Usage - Daily Schedule

```hcl
module "schedule_daily" {
  source = "path/to/Automation/AutomationSchedule"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"
  name                    = "backup-daily"
  description             = "Daily backup at 3 AM"

  frequency  = "Day"
  interval   = 1
  start_time = "2024-01-01T03:00:00+00:00"
  timezone   = "Europe/Madrid"
}
```

## Usage - Weekly Schedule (Specific Days)

```hcl
module "schedule_weekly" {
  source = "path/to/Automation/AutomationSchedule"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"
  name                    = "weekly-report"
  description             = "Generate report on weekdays"

  frequency  = "Week"
  interval   = 1
  start_time = "2024-01-01T08:00:00+00:00"
  timezone   = "Europe/Madrid"

  week_days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
}
```

## Usage - Monthly Schedule (Specific Days of Month)

```hcl
module "schedule_monthly_days" {
  source = "path/to/Automation/AutomationSchedule"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"
  name                    = "monthly-billing"
  description             = "Run on 1st and 15th of each month"

  frequency  = "Month"
  interval   = 1
  start_time = "2024-01-01T06:00:00+00:00"
  timezone   = "UTC"

  month_days = [1, 15]
}
```

## Usage - Monthly Schedule (Last Day of Month)

```hcl
module "schedule_monthly_last" {
  source = "path/to/Automation/AutomationSchedule"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"
  name                    = "end-of-month-close"
  description             = "End of month processing"

  frequency  = "Month"
  interval   = 1
  start_time = "2024-01-01T23:00:00+00:00"
  timezone   = "UTC"

  month_days = [-1]  # Last day of month
}
```

## Usage - Monthly Schedule (Occurrence - e.g., Second Tuesday)

```hcl
module "schedule_monthly_occurrence" {
  source = "path/to/Automation/AutomationSchedule"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"
  name                    = "patch-tuesday"
  description             = "Run on second Tuesday of each month (Patch Tuesday)"

  frequency  = "Month"
  interval   = 1
  start_time = "2024-01-01T04:00:00+00:00"
  timezone   = "UTC"

  monthly_occurrence = {
    day        = "Tuesday"
    occurrence = 2  # Second Tuesday
  }
}
```

## Usage - Monthly Schedule (Last Friday)

```hcl
module "schedule_last_friday" {
  source = "path/to/Automation/AutomationSchedule"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"
  name                    = "monthly-review"
  description             = "Run on last Friday of each month"

  frequency  = "Month"
  interval   = 1
  start_time = "2024-01-01T17:00:00+00:00"
  timezone   = "Europe/Madrid"

  monthly_occurrence = {
    day        = "Friday"
    occurrence = -1  # Last Friday
  }
}
```

## Usage - With Expiry Time

```hcl
module "schedule_with_expiry" {
  source = "path/to/Automation/AutomationSchedule"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"
  name                    = "temporary-task"
  description             = "Runs daily until end of year"

  frequency   = "Day"
  interval    = 1
  start_time  = "2024-01-01T06:00:00+00:00"
  expiry_time = "2024-12-31T23:59:00+00:00"
  timezone    = "UTC"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create` | Controls whether to create the resource | `bool` | `true` | no |
| `resource_group_name` | Name of the Resource Group | `string` | - | yes |
| `automation_account_name` | Name of the Automation Account | `string` | - | yes |
| `name` | Name of the Schedule | `string` | - | yes |
| `description` | Description of the Schedule | `string` | `null` | no |
| `frequency` | Frequency: OneTime, Hour, Day, Week, Month | `string` | - | yes |
| `interval` | Interval between runs (1-100) | `number` | `null` | no |
| `start_time` | Start time in RFC3339 format | `string` | `null` | no |
| `expiry_time` | Expiry time in RFC3339 format | `string` | `null` | no |
| `timezone` | Timezone for the schedule | `string` | `"UTC"` | no |
| `week_days` | Days of week for weekly schedules | `list(string)` | `null` | no |
| `month_days` | Days of month for monthly schedules (1-31, -1) | `list(number)` | `null` | no |
| `monthly_occurrence` | Monthly occurrence (day + week number) | `object` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The ID of the Schedule |
| `name` | The name of the Schedule |
| `start_time` | The start time of the Schedule |
| `expiry_time` | The expiry time of the Schedule |
| `frequency` | The frequency of the Schedule |
| `interval` | The interval of the Schedule |

## Dependencies

- **Resource Group** must exist
- **Automation Account** must exist before creating Schedules

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

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_automation_schedule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_schedule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_automation_account_name"></a> [automation\_account\_name](#input\_automation\_account\_name) | (Required) The name of the Automation Account where the Schedule will be created. DEPENDENCY: Automation Account must exist. | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Schedule. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description for this Schedule. | `string` | `null` | no |
| <a name="input_expiry_time"></a> [expiry\_time](#input\_expiry\_time) | (Optional) End time of the Schedule in RFC3339 format. Schedule will not run after this time. | `string` | `null` | no |
| <a name="input_frequency"></a> [frequency](#input\_frequency) | (Required) The frequency of the Schedule. Possible values: OneTime, Hour, Day, Week, Month. | `string` | n/a | yes |
| <a name="input_interval"></a> [interval](#input\_interval) | (Optional) The number of frequency intervals between runs. Required for Hour, Day, Week, Month frequencies. Valid range: 1-100. | `number` | `null` | no |
| <a name="input_month_days"></a> [month\_days](#input\_month\_days) | (Optional) List of days of the month for monthly schedules. Values: 1-31, or -1 for last day. | `list(number)` | `null` | no |
| <a name="input_monthly_occurrence"></a> [monthly\_occurrence](#input\_monthly\_occurrence) | (Optional) Monthly occurrence for schedules that run on a specific week day.<br/>- day: (Required) Day of the week. Values: Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday.<br/>- occurrence: (Required) Week of the month. Values: 1 (First), 2 (Second), 3 (Third), 4 (Fourth), -1 (Last). | <pre>object({<br/>    day        = string<br/>    occurrence = number<br/>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Schedule. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Automation Account exists. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_start_time"></a> [start\_time](#input\_start\_time) | (Optional) Start time of the Schedule in RFC3339 format (e.g., 2024-01-01T06:00:00+00:00). Must be at least 5 minutes in the future. Defaults to 7 minutes from now. | `string` | `null` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | (Optional) The timezone of the Schedule. Default: UTC. Examples: UTC, Europe/Madrid, America/New\_York. | `string` | `"UTC"` | no |
| <a name="input_week_days"></a> [week\_days](#input\_week\_days) | (Optional) List of days of the week for weekly schedules. Values: Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday. | `list(string)` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_expiry_time"></a> [expiry\_time](#output\_expiry\_time) | The expiry time of the Schedule. |
| <a name="output_frequency"></a> [frequency](#output\_frequency) | The frequency of the Schedule. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Automation Schedule. |
| <a name="output_interval"></a> [interval](#output\_interval) | The interval of the Schedule. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Automation Schedule. |
| <a name="output_start_time"></a> [start\_time](#output\_start\_time) | The start time of the Schedule. |
<!-- END_TF_DOCS -->