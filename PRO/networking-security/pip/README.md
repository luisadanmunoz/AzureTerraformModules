# Terraform Module: Public IP

Este módulo de Terraform crea y configura una dirección IP pública en Azure.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_public_ip.public_ip`: Crea una dirección IP pública en Azure.
- `azurerm_monitor_diagnostic_setting.diagnostic_setting`: Configura el monitoreo y diagnóstico de la IP pública.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                    | Tipo        | Descripción                                            | Por defecto |
|---------------------------|------------|--------------------------------------------------------|------------|
| `name`                    | `string`   | Nombre de la IP pública.                              | -          |
| `location`                | `string`   | Ubicación donde se desplegará la IP pública.         | -          |
| `resource_group_name`      | `string`   | Nombre del grupo de recursos donde se creará la IP.  | -          |
| `allocation_method`        | `string`   | Método de asignación (`Static` o `Dynamic`).         | -          |
| `sku`                     | `string`   | SKU de la IP pública (`Basic` o `Standard`).         | -          |
| `zones`                   | `list(string)` | Zonas de disponibilidad en las que se desplegará.  | `{}`       |
| `tags`                    | `map(any)` | Etiquetas opcionales para el recurso.                | `{}`       |
| `name_diagnostic_setting`  | `string`   | Nombre de la configuración de diagnóstico.           | `{}`       |
| `workspace_resource_id`    | `string`   | ID del Log Analytics Workspace para monitoreo.       | `{}`       |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre  | Descripción                      |
|---------|----------------------------------|
| `id`    | ID de la IP pública.            |
| `name`  | Nombre de la IP pública.        |

## Uso

Ejemplo de uso del módulo:

```hcl
module "public_ip" {
  source                  = "./ruta/al/modulo"
  name                    = "mi-public-ip"
  location                = "East US"
  resource_group_name     = "mi-grupo-de-recursos"
  allocation_method       = "Static"
  sku                     = "Standard"
  zones                   = ["1", "2", "3"]
  tags                    = { env = "prod" }
  name_diagnostic_setting = "public-ip-diagnostics"
  workspace_resource_id   = "log-analytics-id"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de direcciones IP públicas en Azure.

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
| [azurerm_monitor_diagnostic_setting.diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_public_ip.public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_monitor_diagnostic_categories.diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allocation_method"></a> [allocation\_method](#input\_allocation\_method) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | ############################################################################ PUBLIC IP VARIABLES ############################################################################ | `string` | n/a | yes |
| <a name="input_name_diagnostic_setting"></a> [name\_diagnostic\_setting](#input\_name\_diagnostic\_setting) | ############################################################################ PUBLIC IP VARIABLES DIAGNOSTIC SETTING ############################################################################ | `map` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | `{}` | no |
| <a name="input_workspace_resource_id"></a> [workspace\_resource\_id](#input\_workspace\_resource\_id) | n/a | `map` | `{}` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | n/a | `map` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################# PUBLIC IP OUTPUTS ############################################################################# |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->