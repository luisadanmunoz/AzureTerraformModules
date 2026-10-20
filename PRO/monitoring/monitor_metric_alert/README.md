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
| [azurerm_monitor_metric_alert.monitor_metric_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_action_group_id"></a> [action\_group\_id](#input\_action\_group\_id) | value of the action group id tag | `string` | n/a | yes |
| <a name="input_aggregation"></a> [aggregation](#input\_aggregation) | value of the aggregation tag | `string` | n/a | yes |
| <a name="input_auto_mitigate"></a> [auto\_mitigate](#input\_auto\_mitigate) | value of the auto mitigate tag | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | value of the description tag | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | value of the enabled tag | `string` | n/a | yes |
| <a name="input_frequency"></a> [frequency](#input\_frequency) | value of the frequency tag | `string` | n/a | yes |
| <a name="input_metric_name"></a> [metric\_name](#input\_metric\_name) | value of the metric name tag | `string` | n/a | yes |
| <a name="input_metric_namespace"></a> [metric\_namespace](#input\_metric\_namespace) | value of the metric namespace tag | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | value of the name tag | `string` | n/a | yes |
| <a name="input_operator"></a> [operator](#input\_operator) | value of the operator tag | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value of the resource group name tag | `string` | n/a | yes |
| <a name="input_scopes"></a> [scopes](#input\_scopes) | value of the scopes tag | `any` | n/a | yes |
| <a name="input_severity"></a> [severity](#input\_severity) | value of the severity tag | `string` | n/a | yes |
| <a name="input_threshold"></a> [threshold](#input\_threshold) | value of the threshold tag | `string` | n/a | yes |
| <a name="input_window_size"></a> [window\_size](#input\_window\_size) | value of the window size tag | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->