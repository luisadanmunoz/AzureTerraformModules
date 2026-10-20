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
| [azurerm_cost_anomaly_alert.cost_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cost_anomaly_alert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | value of the display name tag | `string` | n/a | yes |
| <a name="input_email_addresses"></a> [email\_addresses](#input\_email\_addresses) | value of the email addresses tag | `set(string)` | n/a | yes |
| <a name="input_email_subject"></a> [email\_subject](#input\_email\_subject) | value of the email subject tag | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | value of the name tag | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | value of the subscription id tag | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->