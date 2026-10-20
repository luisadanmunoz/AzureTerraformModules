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
| [azurerm_log_analytics_workspace.log_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_location"></a> [location](#input\_location) | value of the location tag | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | value of the name tag | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value of the resource group name tag | `string` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | value of the retention in days tag | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | value of the sku tag | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value of the tags tag | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | value of the id tag |
| <a name="output_name"></a> [name](#output\_name) | value of the name tag |
<!-- END_TF_DOCS -->