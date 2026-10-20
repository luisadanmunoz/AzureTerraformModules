# Terraform Module: Monitor Activity Log Alert

Este módulo de Terraform crea una alerta de registro de actividad en Azure Monitor.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_monitor_activity_log_alert.monitor_activity_log_alert`: Crea una alerta basada en registros de actividad de Azure Monitor.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                | Tipo        | Descripción                                                  | Por defecto |
|-----------------------|------------|--------------------------------------------------------------|------------|
| `name`               | `string`   | Nombre de la alerta de registro de actividad.               | -          |
| `resource_group_name` | `string`   | Nombre del grupo de recursos donde se creará la alerta.     | -          |
| `scopes`             | `set(string)` | Alcance de la alerta (ej. suscripciones o grupos de recursos). | -          |
| `description`        | `string`   | Descripción de la alerta.                                   | -          |
| `category`           | `string`   | Categoría del evento en el registro de actividad.          | -          |
| `location`           | `string`   | Ubicación del recurso de alerta.                           | -          |
| `action_group_id`    | `string`   | ID del grupo de acción asociado a la alerta.               | -          |

## Uso

Ejemplo de uso del módulo:

```hcl
module "monitor_activity_log_alert" {
  source              = "./ruta/al/modulo"
  name                = "alerta-actividad"
  resource_group_name = "mi-grupo-de-recursos"
  scopes              = ["/subscriptions/sub-id"]
  description         = "Alerta de actividad en Azure"
  category           = "Administrative"
  location           = "East US"
  action_group_id    = "action-group-id"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de alertas de actividad en Azure Monitor.
