# Azure Monitor Metric Alert

Terraform module for creating Azure Monitor Metric Alert resources.

## Features

- Multi-criteria metric alerts
- Configurable severity, frequency, and evaluation window
- Action Group integration for notifications
- Auto-mitigation support
- Conditional resource creation

## Usage

```hcl
module "metric_alert" {
  source = "path/to/MonitoringAndDashboards/MetricAlert"

  name                = "alert-high-cpu"
  resource_group_name = azurerm_resource_group.monitoring.name
  scopes              = [azurerm_virtual_machine.main.id]
  severity            = 2

  criteria = [
    {
      metric_namespace = "Microsoft.Compute/virtualMachines"
      metric_name      = "Percentage CPU"
      aggregation      = "Average"
      operator         = "GreaterThan"
      threshold        = 90
    }
  ]

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
| scopes | Resource IDs to monitor | `list(string)` | n/a | yes |
| criteria | Metric criteria | `list(object)` | n/a | yes |
| severity | Alert severity (0-4) | `number` | `3` | no |
| frequency | Evaluation frequency | `string` | `"PT5M"` | no |
| window_size | Evaluation window | `string` | `"PT5M"` | no |
| action_group_ids | Action Group IDs | `list(string)` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The alert ID |
| name | The alert name |
