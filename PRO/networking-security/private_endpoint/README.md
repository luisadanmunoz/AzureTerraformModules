# Terraform Module: Private Endpoint

Este módulo de Terraform crea y configura un Private Endpoint en Azure para conectar servicios privados dentro de una red virtual.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_private_endpoint.private_endpoint`: Crea un Private Endpoint en Azure.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                              | Tipo    | Descripción                                                      | Por defecto |
|-------------------------------------|--------|------------------------------------------------------------------|------------|
| `name`                              | `string` | Nombre del Private Endpoint.                                     | -          |
| `location`                          | `string` | Ubicación donde se desplegará el Private Endpoint.               | -          |
| `resource_group_name`               | `string` | Nombre del grupo de recursos donde se creará el Private Endpoint. | -          |
| `subnet_id`                         | `string` | ID de la subred donde se desplegará el Private Endpoint.         | -          |
| `custom_network_interface_name`     | `string` | Nombre de la interfaz de red personalizada.                      | -          |
| `name_private_service_connection`   | `string` | Nombre de la conexión de servicio privado.                      | -          |
| `private_connection_resource_alias` | `bool`   | Indica si se usará un alias para la conexión.                    | -          |
| `alias`                             | `string` | Alias del recurso privado si se usa conexión con alias.          | -          |
| `private_connection_resource_id`    | `bool`   | Indica si se usará un ID de recurso para la conexión.           | -          |
| `id`                                | `string` | ID del recurso privado si se usa conexión con ID.                | -          |
| `subresource_names`                 | `bool`   | Indica si se usarán subrecursos en la conexión.                 | -          |
| `subresource`                       | `string` | Nombre del subrecurso si aplica.                                 | -          |

## Uso

Ejemplo de uso del módulo:

```hcl
module "private_endpoint" {
  source                          = "./ruta/al/modulo"
  name                            = "mi-private-endpoint"
  location                        = "East US"
  resource_group_name             = "mi-grupo-de-recursos"
  subnet_id                       = "subnet-id"
  custom_network_interface_name   = "private-endpoint-nic"
  name_private_service_connection = "service-connection"
  private_connection_resource_alias = true
  alias                           = "privateservice.alias"
  private_connection_resource_id  = false
  id                              = ""
  subresource_names               = true
  subresource                     = "subresource-name"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de Private Endpoints en Azure.