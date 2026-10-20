# Terraform Module: Azure Function App

Este módulo de Terraform crea y configura un Azure Function App con soporte para Private Endpoint.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_app_service_plan.iot_function`: Crea un App Service Plan en Azure para la Function App.
- `azurerm_function_app.iot_function`: Crea un Azure Function App.
- `azurerm_private_endpoint.private_endpoint`: Configura un Private Endpoint para la Function App.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                     | Tipo        | Descripción                                               | Por defecto |
|----------------------------|------------|-----------------------------------------------------------|------------|
| `name_app_service_plan`    | `string`   | Nombre del App Service Plan.                             | -          |
| `resource_group_name`      | `string`   | Nombre del grupo de recursos donde se creará la Function App. | -          |
| `location`                 | `string`   | Ubicación donde se desplegará la Function App.           | -          |
| `tags`                     | `map(any)` | Etiquetas opcionales para el recurso.                    | `{}`       |
| `name_function_app`        | `string`   | Nombre de la Function App.                               | -          |
| `storage_account_name`     | `string`   | Nombre de la cuenta de almacenamiento asociada.         | -          |
| `storage_account_access_key` | `string` | Clave de acceso a la cuenta de almacenamiento.         | -          |
| `subnet_id`                | `string`   | ID de la subred donde se configurará el Private Endpoint. | -          |
| `private_dns_zone_ids`     | `string`   | ID de la zona privada de DNS asociada.                  | -          |

## Outputs

Este módulo no define outputs específicos.

## Uso

Ejemplo de uso del módulo:

```hcl
module "function_app" {
  source                     = "./ruta/al/modulo"
  name_app_service_plan       = "mi-app-service-plan"
  resource_group_name         = "mi-grupo-de-recursos"
  location                    = "East US"
  tags                        = { env = "prod" }
  name_function_app           = "mi-function-app"
  storage_account_name        = "mi-storage-account"
  storage_account_access_key  = "mi-access-key"
  subnet_id                   = "subnet-id"
  private_dns_zone_ids        = "dns-zone-id"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de Azure Function App con soporte para Private Endpoint en Azure.