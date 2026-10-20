# Terraform Module: Monitor Scheduled Query Rules Alert

Este módulo de Terraform crea una alerta basada en consultas programadas en Azure Monitor.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_monitor_scheduled_query_rules_alert.disk_space_alert`: Crea una alerta basada en consultas KQL en Azure Monitor.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                | Tipo        | Descripción                                                  | Por defecto |
|-----------------------|------------|--------------------------------------------------------------|------------|
| `name`               | `string`   | Nombre de la alerta de consulta programada.                 | -          |
| `resource_group_name` | `string`   | Nombre del grupo de recursos donde se creará la alerta.     | -          |
| `location`           | `string`   | Ubicación del recurso de alerta.                           | -          |
| `severity`           | `string`   | Nivel de severidad de la alerta (1-5).                     | -          |
| `enabled`            | `string`   | Estado de habilitación de la alerta.                       | -          |
| `description`        | `string`   | Descripción de la alerta.                                   | -          |
| `log_analytics`      | `string`   | ID del Log Analytics Workspace.                            | -          |
| `query`             | `string`   | Consulta KQL utilizada para evaluar la alerta.             | -          |
| `time_window`       | `string`   | Ventana de tiempo de evaluación de la consulta.            | -          |
| `frequency`         | `string`   | Frecuencia con la que se ejecuta la consulta.              | -          |
| `threshold`         | `string`   | Umbral de activación de la alerta.                         | -          |
| `operator`          | `string`   | Operador de comparación (`GreaterThan`, `LessThan`, etc.). | -          |
| `action_group_id`   | `set(string)` | ID del grupo de acción asociado a la alerta.               | -          |

## Uso

Ejemplo de uso del módulo:

```hcl
module "monitor_scheduled_query_alert" {
  source              = "./ruta/al/modulo"
  name                = "disk-space-alert"
  resource_group_name = "mi-grupo-de-recursos"
  location           = "East US"
  severity           = "2"
  enabled            = "true"
  description        = "Alerta de espacio en disco en Azure"
  log_analytics      = "log-analytics-id"
  query             = <<EOT
    InsightsMetrics
    | where Namespace == "LogicalDisk" and Name == "FreeSpacePercentage"
    | summarize AggregatedValue = avg(Val) by bin(TimeGenerated, 15m), Computer, _ResourceId
EOT
  time_window       = "PT15M"
  frequency         = "PT5M"
  threshold         = "10"
  operator          = "LessThan"
  action_group_id   = ["action-group-id"]
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de alertas de consultas programadas en Azure Monitor.
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
| [azurerm_monitor_scheduled_query_rules_alert.disk_space_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_action_group_id"></a> [action\_group\_id](#input\_action\_group\_id) | value of the action group id tag | `set(string)` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | value of the description tag | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | value of the enabled tag | `string` | n/a | yes |
| <a name="input_frequency"></a> [frequency](#input\_frequency) | value of the frequency tag | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | value of the location tag | `string` | n/a | yes |
| <a name="input_log_analytics"></a> [log\_analytics](#input\_log\_analytics) | value of the log analytics tag | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | value of the name tag | `string` | n/a | yes |
| <a name="input_operator"></a> [operator](#input\_operator) | value of the operator tag | `string` | n/a | yes |
| <a name="input_query"></a> [query](#input\_query) | value of the query tag | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value of the resource group name tag | `string` | n/a | yes |
| <a name="input_severity"></a> [severity](#input\_severity) | value of the severity tag | `string` | n/a | yes |
| <a name="input_threshold"></a> [threshold](#input\_threshold) | value of the threshold tag | `string` | n/a | yes |
| <a name="input_time_window"></a> [time\_window](#input\_time\_window) | value of the time window tag | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->