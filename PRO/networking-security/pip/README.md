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
