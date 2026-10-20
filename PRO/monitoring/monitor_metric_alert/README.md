# Terraform Module: Monitor Metric Alert

Este módulo de Terraform crea una alerta de métrica en Azure Monitor.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_monitor_metric_alert.monitor_metric_alert`: Crea una alerta basada en métricas de Azure Monitor.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                | Tipo        | Descripción                                                  | Por defecto |
|-----------------------|------------|--------------------------------------------------------------|------------|
| `name`               | `string`   | Nombre de la alerta de métrica.                             | -          |
| `resource_group_name` | `string`   | Nombre del grupo de recursos donde se creará la alerta.     | -          |
| `scopes`             | `any`      | Alcance de la alerta (ej. suscripciones o recursos específicos). | -          |
| `description`        | `string`   | Descripción de la alerta.                                   | -          |
| `metric_namespace`   | `string`   | Espacio de nombres de la métrica a monitorizar.            | -          |
| `metric_name`        | `string`   | Nombre de la métrica a monitorizar.                        | -          |
| `aggregation`        | `string`   | Tipo de agregación (Ej. `Average`, `Total`).               | -          |
| `operator`           | `string`   | Operador de comparación (`GreaterThan`, `LessThan`, etc.). | -          |
| `threshold`          | `string`   | Umbral de activación de la alerta.                         | -          |
| `severity`           | `string`   | Nivel de severidad de la alerta (1-5).                     | -          |
| `enabled`            | `string`   | Estado de habilitación de la alerta.                       | -          |
| `frequency`          | `string`   | Frecuencia de evaluación de la métrica.                    | -          |
| `window_size`        | `string`   | Tamaño de la ventana de análisis de métricas.              | -          |
| `auto_mitigate`      | `string`   | Habilita la mitigación automática (`true` o `false`).      | -          |
| `action_group_id`    | `string`   | ID del grupo de acción asociado a la alerta.               | -          |

## Uso

Ejemplo de uso del módulo:

```hcl
module "monitor_metric_alert" {
  source              = "./ruta/al/modulo"
  name                = "cpu-alert"
  resource_group_name = "mi-grupo-de-recursos"
  scopes              = ["/subscriptions/sub-id/resourceGroups/rg-name/providers/Microsoft.Compute/virtualMachines/vm-name"]
  description         = "Alerta de CPU en Azure"
  metric_namespace    = "Microsoft.Compute/virtualMachines"
  metric_name         = "Percentage CPU"
  aggregation        = "Average"
  operator           = "GreaterThan"
  threshold          = "80"
  severity           = "2"
  enabled            = "true"
  frequency          = "PT1M"
  window_size        = "PT5M"
  auto_mitigate      = "true"
  action_group_id    = "action-group-id"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de alertas de métrica en Azure Monitor.
