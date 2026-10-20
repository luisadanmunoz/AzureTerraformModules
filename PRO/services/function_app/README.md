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
| [azurerm_app_service_plan.iot_function](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan) | resource |
| [azurerm_function_app.iot_function](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app) | resource |
| [azurerm_private_endpoint.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_location"></a> [location](#input\_location) | n/a | `map` | `{}` | no |
| <a name="input_name_app_service_plan"></a> [name\_app\_service\_plan](#input\_name\_app\_service\_plan) | n/a | `map` | `{}` | no |
| <a name="input_name_function_app"></a> [name\_function\_app](#input\_name\_function\_app) | n/a | `map` | `{}` | no |
| <a name="input_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#input\_private\_dns\_zone\_ids) | n/a | `map` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `map` | `{}` | no |
| <a name="input_storage_account_access_key"></a> [storage\_account\_access\_key](#input\_storage\_account\_access\_key) | n/a | `map` | `{}` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | n/a | `map` | `{}` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `map` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->