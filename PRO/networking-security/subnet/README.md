# Terraform Module: Subnet

Este módulo de Terraform crea y configura una subred en una red virtual de Azure, con soporte para delegaciones, asociaciones con NSG y tablas de rutas.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_subnet.subnet`: Crea una subred en una red virtual de Azure.
- `azurerm_subnet_network_security_group_association.subnet_nsg_association`: Asocia la subred con un Network Security Group.
- `azurerm_subnet_route_table_association.assoc-snet-rt`: Asocia la subred con una tabla de rutas.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                              | Tipo           | Descripción                                                            | Por defecto |
|-------------------------------------|---------------|------------------------------------------------------------------------|------------|
| `name`                              | `string`      | Nombre de la subred.                                                  | -          |
| `resource_group_name`               | `string`      | Nombre del grupo de recursos en el que se creará la subred.           | -          |
| `virtual_network_name`              | `string`      | Nombre de la red virtual donde se implementará la subred.             | -          |
| `address_prefixes`                  | `list(string)`| Lista de prefijos de direcciones IP para la subred.                   | -          |
| `use_service_endpoints`             | `bool`        | Indica si los service endpoints de servicio deben habilitarse.         | `false`    |
| `service_endpoints`                 | `list(string)`| Lista de endpoints de servicio si están habilitados.                   | `[]`       |
| `default_outbound_access_enabled`   | `bool`        | Habilita el acceso de salida predeterminado.                           | -          |
| `enable_delegation`                 | `bool`        | Habilita la delegación de la subred a un servicio específico.         | -          |
| `name_delegation`                   | `string`      | Nombre de la delegación.                                               | -          |
| `name_service_delegation`           | `string`      | Nombre del servicio delegado.                                          | -          |
| `use_actions`                       | `bool`        | Indica si las acciones de delegación deben habilitarse.                | `false`    |
| `actions`                           | `list(string)`| Lista de acciones de delegación si está habilitada.                    | `[]`       |
| `nsg_assoc`                         | `bool`        | Indica si la subred debe asociarse con un NSG.                         | -          |
| `nsg_id`                            | `string`      | ID del Network Security Group si se asocia.                           | -          |
| `route_table_assoc`                 | `bool`        | Indica si la subred debe asociarse con una tabla de rutas.             | -          |
| `route_table_id`                    | `string`      | ID de la tabla de rutas si se asocia.                                  | -          |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre  | Descripción                        |
|---------|------------------------------------|
| `id`    | ID de la subred creada.           |
| `name`  | Nombre de la subred creada.       |

## Uso

Ejemplo de uso del módulo:

```hcl
module "subnet" {
  source                = "./ruta/al/modulo"
  name                  = "mi-subnet"
  resource_group_name   = "mi-grupo-de-recursos"
  virtual_network_name  = "mi-vnet"
  address_prefixes      = ["10.0.1.0/24"]
  use_service_endpoints = true
  service_endpoints     = ["Microsoft.Storage"]
  default_outbound_access_enabled = true
  enable_delegation     = false
  nsg_assoc            = true
  nsg_id               = "nsg-id"
  route_table_assoc    = true
  route_table_id       = "rt-id"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de subredes en Azure.
