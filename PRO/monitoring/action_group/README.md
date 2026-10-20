# Terraform Module: Action Group

Este módulo de Terraform crea un grupo de acción en Azure Monitor para gestionar notificaciones y alertas.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_monitor_action_group.action_group`: Crea un grupo de acción en Azure Monitor con correos electrónicos y webhooks configurados.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre            | Tipo        | Descripción                                          | Por defecto |
|------------------|------------|------------------------------------------------------|------------|
| `name`           | `string`   | Nombre del grupo de acción.                         | -          |
| `resource_group` | `string`   | Nombre del grupo de recursos donde se creará.      | -          |
| `short_name`     | `string`   | Nombre corto del grupo de acción.                   | -          |
| `commom_tags`    | `map(any)` | Etiquetas comunes para el grupo de acción.         | `{}`       |
| `name_webhook`   | `string`   | Nombre del webhook receptor.                        | -          |
| `uri`           | `string`   | URI del servicio webhook receptor.                  | -          |
| `name_email`     | `string`   | Nombre del primer receptor de correo.               | -          |
| `email`         | `string`   | Dirección de correo del primer receptor.            | -          |
| `name_email2`    | `string`   | Nombre del segundo receptor de correo.              | -          |
| `email2`        | `string`   | Dirección de correo del segundo receptor.           | -          |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre  | Descripción                                  |
|---------|----------------------------------------------|
| `id`    | ID del grupo de acción en Azure Monitor.   |
| `name`  | Nombre del grupo de acción.                 |

## Uso

Ejemplo de uso del módulo:

```hcl
module "action_group" {
  source          = "./ruta/al/modulo"
  name            = "mi-action-group"
  resource_group  = "mi-grupo-de-recursos"
  short_name      = "AGTest"
  commom_tags     = { env = "dev" }
  name_webhook    = "webhook-test"
  uri             = "https://example.com/webhook"
  name_email      = "admin-alerts"
  email           = "admin@example.com"
  name_email2     = "support-alerts"
  email2          = "support@example.com"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de grupos de acción en Azure Monitor.
