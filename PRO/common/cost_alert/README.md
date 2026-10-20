# Terraform Module: Cost Anomaly Alert

Este módulo de Terraform crea una alerta de anomalía de costos en Azure.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_cost_anomaly_alert.cost_alert`: Crea una alerta de anomalía de costos basada en suscripciones.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre             | Tipo         | Descripción                                              | Por defecto |
|-------------------|-------------|----------------------------------------------------------|------------|
| `name`            | `string`    | Nombre de la alerta de costos.                          | -          |
| `display_name`    | `string`    | Nombre para mostrar de la alerta de costos.             | -          |
| `subscription_id` | `string`    | ID de la suscripción en Azure a monitorear.            | -          |
| `email_subject`   | `string`    | Asunto del correo de notificación.                      | -          |
| `email_addresses` | `set(string)` | Lista de direcciones de correo para recibir alertas.    | -          |

## Uso

Ejemplo de uso del módulo:

```hcl
module "cost_alert" {
  source           = "./ruta/al/modulo"
  name             = "cost-alert"
  display_name     = "Alerta de Costos"
  subscription_id  = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  email_subject    = "Alerta de Anomalía de Costos"
  email_addresses  = ["admin@example.com", "finance@example.com"]
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de alertas de anomalías de costos en Azure.