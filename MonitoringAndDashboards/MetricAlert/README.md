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
| [azurerm_monitor_metric_alert.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_action_group_ids"></a> [action\_group\_ids](#input\_action\_group\_ids) | List of Action Group IDs to notify. | `list(string)` | `[]` | no |
| <a name="input_auto_mitigate"></a> [auto\_mitigate](#input\_auto\_mitigate) | Whether to auto-resolve the alert. | `bool` | `true` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the Metric Alert. | `bool` | `true` | no |
| <a name="input_criteria"></a> [criteria](#input\_criteria) | List of metric criteria. | <pre>list(object({<br/>    metric_namespace = string<br/>    metric_name      = string<br/>    aggregation      = string<br/>    operator         = string<br/>    threshold        = number<br/>  }))</pre> | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The description of the Metric Alert. | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether the Metric Alert is enabled. | `bool` | `true` | no |
| <a name="input_frequency"></a> [frequency](#input\_frequency) | The evaluation frequency. Possible values: PT1M, PT5M, PT15M, PT30M, PT1H. | `string` | `"PT5M"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Metric Alert. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_scopes"></a> [scopes](#input\_scopes) | List of resource IDs to monitor. | `list(string)` | n/a | yes |
| <a name="input_severity"></a> [severity](#input\_severity) | The severity of the alert. Possible values: 0 (Critical), 1 (Error), 2 (Warning), 3 (Informational), 4 (Verbose). | `number` | `3` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |
| <a name="input_window_size"></a> [window\_size](#input\_window\_size) | The period of time to evaluate. Possible values: PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H, P1D. | `string` | `"PT5M"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Metric Alert. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Metric Alert. |
<!-- END_TF_DOCS -->