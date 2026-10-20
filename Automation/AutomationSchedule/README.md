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
