# Terraform Module: Azure Event Hub

Este módulo de Terraform crea y configura un Azure Event Hub con un Private Endpoint y una regla de autorización.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_eventhub_namespace.namespace`: Crea un espacio de nombres de Event Hub en Azure.
- `azurerm_eventhub.eventhub`: Crea un Event Hub dentro del espacio de nombres.
- `azurerm_eventhub_authorization_rule.authorization_rule`: Crea una regla de autorización para el Event Hub.
- `azurerm_private_endpoint.private_endpoint`: Configura un Private Endpoint para el Event Hub.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                     | Tipo        | Descripción                                                | Por defecto |
|----------------------------|------------|------------------------------------------------------------|------------|
| `namespace`                | `string`   | Nombre del espacio de nombres del Event Hub.              | -          |
| `location`                 | `string`   | Ubicación donde se desplegará el Event Hub.               | -          |
| `resource_group_name`      | `string`   | Nombre del grupo de recursos donde se creará el Event Hub. | -          |
| `private_dns_zone_ids`     | `string`   | ID de la zona privada de DNS asociada.                    | -          |
| `tags`                     | `map(any)` | Etiquetas opcionales para el recurso.                     | `{}`       |
| `name_eventhub`            | `string`   | Nombre del Event Hub.                                      | -          |
| `subnet_id`                | `string`   | ID de la subred donde se configurará el Private Endpoint. | -          |
| `name_authorization_rule`  | `string`   | Nombre de la regla de autorización.                       | -          |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre  | Descripción                                      |
|---------|--------------------------------------------------|
| `name`  | Nombre del Event Hub.                           |
| `id`    | Cadena de conexión primaria del Event Hub.     |

## Uso

Ejemplo de uso del módulo:

```hcl
module "eventhub" {
  source                   = "./ruta/al/modulo"
  namespace                = "mi-eventhub-namespace"
  location                 = "East US"
  resource_group_name      = "mi-grupo-de-recursos"
  private_dns_zone_ids     = "dns-zone-id"
  tags                     = { env = "prod" }
  name_eventhub            = "mi-eventhub"
  subnet_id                = "subnet-id"
  name_authorization_rule  = "mi-regla-autorizacion"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de Azure Event Hub con Private Endpoint y reglas de autorización en Azure.