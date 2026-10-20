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