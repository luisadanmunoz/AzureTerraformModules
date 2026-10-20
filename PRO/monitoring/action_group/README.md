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
| [azurerm_monitor_action_group.action_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_commom_tags"></a> [commom\_tags](#input\_commom\_tags) | value of the commom tags tag | `map` | `{}` | no |
| <a name="input_email"></a> [email](#input\_email) | value of the email tag | `string` | n/a | yes |
| <a name="input_email2"></a> [email2](#input\_email2) | value of the email2 tag | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | value of the name tag | `string` | n/a | yes |
| <a name="input_name_email"></a> [name\_email](#input\_name\_email) | value of the name email tag | `string` | n/a | yes |
| <a name="input_name_email2"></a> [name\_email2](#input\_name\_email2) | value of the name email2 tag | `string` | n/a | yes |
| <a name="input_name_webhook"></a> [name\_webhook](#input\_name\_webhook) | value of the name webhook tag | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | value of the resource group tag | `string` | n/a | yes |
| <a name="input_short_name"></a> [short\_name](#input\_short\_name) | value of the short name tag | `string` | n/a | yes |
| <a name="input_uri"></a> [uri](#input\_uri) | value of the uri tag | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | value of the id tag |
| <a name="output_name"></a> [name](#output\_name) | value of the name tag |
<!-- END_TF_DOCS -->