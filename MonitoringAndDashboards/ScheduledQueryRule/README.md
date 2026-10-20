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
| [azurerm_monitor_scheduled_query_rules_alert_v2.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert_v2) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_action_group_ids"></a> [action\_group\_ids](#input\_action\_group\_ids) | List of Action Group IDs to notify. | `list(string)` | `[]` | no |
| <a name="input_auto_mitigation_enabled"></a> [auto\_mitigation\_enabled](#input\_auto\_mitigation\_enabled) | Whether auto-mitigation is enabled. | `bool` | `true` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the Scheduled Query Rule Alert. | `bool` | `true` | no |
| <a name="input_criteria"></a> [criteria](#input\_criteria) | The criteria for the alert. | <pre>object({<br/>    query                   = string<br/>    time_aggregation_method = string<br/>    threshold               = number<br/>    operator                = string<br/>    metric_measure_column   = optional(string)<br/>    resource_id_column      = optional(string)<br/>    dimension = optional(list(object({<br/>      name     = string<br/>      operator = string<br/>      values   = list(string)<br/>    })), [])<br/>    failing_periods = optional(object({<br/>      minimum_failing_periods_to_trigger_alert = number<br/>      number_of_evaluation_periods             = number<br/>    }))<br/>  })</pre> | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The description of the alert. | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether the alert is enabled. | `bool` | `true` | no |
| <a name="input_evaluation_frequency"></a> [evaluation\_frequency](#input\_evaluation\_frequency) | How often the rule is evaluated. Possible values: PT1M, PT5M, PT10M, PT15M, PT30M, PT45M, PT1H, PT2H, PT3H, PT4H, PT5H, PT6H, P1D. | `string` | `"PT5M"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Scheduled Query Rule Alert. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_scopes"></a> [scopes](#input\_scopes) | List of resource IDs to scope the alert. | `list(string)` | n/a | yes |
| <a name="input_severity"></a> [severity](#input\_severity) | The severity. Possible values: 0 (Critical), 1 (Error), 2 (Warning), 3 (Informational), 4 (Verbose). | `number` | `3` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |
| <a name="input_window_duration"></a> [window\_duration](#input\_window\_duration) | The period of time on which the alert is evaluated. Possible values: PT1M, PT5M, PT10M, PT15M, PT30M, PT45M, PT1H, PT2H, PT3H, PT4H, PT5H, PT6H, P1D, P2D. | `string` | `"PT5M"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Scheduled Query Rule Alert. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Scheduled Query Rule Alert. |
<!-- END_TF_DOCS -->