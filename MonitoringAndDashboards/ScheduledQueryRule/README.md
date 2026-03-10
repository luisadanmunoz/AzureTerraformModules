# Azure Monitor Scheduled Query Rule Alert

Terraform module for creating Azure Monitor Scheduled Query Rule Alert resources.

## Features

- KQL query-based alerting on Log Analytics data
- Configurable severity, frequency, and evaluation window
- Dimension-based filtering
- Failing periods for alert stability
- Action Group integration
- Conditional resource creation

## Usage

```hcl
module "query_alert" {
  source = "path/to/MonitoringAndDashboards/ScheduledQueryRule"

  name                = "alert-high-errors"
  resource_group_name = azurerm_resource_group.monitoring.name
  location            = "eastus"
  scopes              = [azurerm_log_analytics_workspace.main.id]
  severity            = 1

  criteria = {
    query                   = "AppExceptions | summarize count() by bin(TimeGenerated, 5m)"
    time_aggregation_method = "Count"
    threshold               = 10
    operator                = "GreaterThan"
  }

  action_group_ids = [module.action_group.id]
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Alert name | `string` | n/a | yes |
| resource_group_name | Resource group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| scopes | Resource IDs to scope | `list(string)` | n/a | yes |
| criteria | Query criteria | `object` | n/a | yes |
| severity | Alert severity (0-4) | `number` | `3` | no |
| evaluation_frequency | Evaluation frequency | `string` | `"PT5M"` | no |
| window_duration | Evaluation window | `string` | `"PT5M"` | no |
| action_group_ids | Action Group IDs | `list(string)` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The alert ID |
| name | The alert name |
