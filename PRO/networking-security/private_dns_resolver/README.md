# Terraform Module: Private DNS Resolver

Este módulo de Terraform crea y configura un Private DNS Resolver en Azure, permitiendo resolver nombres de dominio privados dentro de redes virtuales.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_private_dns_resolver.private_dns_resolver`: Crea un Private DNS Resolver.
- `azurerm_private_dns_resolver_outbound_endpoint.outbound_endpoint`: Crea un endpoint de salida para el DNS Resolver.
- `azurerm_private_dns_resolver_inbound_endpoint.inbound_endpoint`: Crea un endpoint de entrada para el DNS Resolver.
- `azurerm_private_dns_resolver_dns_forwarding_ruleset.forwarding_ruleset`: Configura un conjunto de reglas de reenvío de DNS.
- `azurerm_private_dns_resolver_virtual_network_link.network_link`: Establece un enlace entre el DNS Resolver y una red virtual.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                           | Tipo        | Descripción                                                | Por defecto |
|----------------------------------|------------|------------------------------------------------------------|------------|
| `name`                           | `string`   | Nombre del Private DNS Resolver.                          | -          |
| `resource_group_name`            | `string`   | Nombre del grupo de recursos donde se creará el resolver. | -          |
| `location`                       | `string`   | Ubicación del recurso.                                    | -          |
| `virtual_network_id`             | `string`   | ID de la red virtual asociada al DNS Resolver.            | -          |
| `tags`                           | `map(any)` | Etiquetas opcionales para el recurso.                     | `{}`       |
| `name_outbound`                  | `string`   | Nombre del endpoint de salida.                            | -          |
| `subnet_id_outbound`             | `string`   | ID de la subred donde se implementará el endpoint de salida. | -          |
| `name_inbound`                   | `string`   | Nombre del endpoint de entrada.                           | -          |
| `private_ip`                     | `string`   | Dirección IP privada para el endpoint de entrada.         | -          |
| `subnet_id_inbound`              | `string`   | ID de la subred donde se implementará el endpoint de entrada. | -          |
| `name_forwarding_ruleset`        | `string`   | Nombre del conjunto de reglas de reenvío de DNS.         | -          |
| `name_virtual_network_link`      | `string`   | Nombre del enlace con la red virtual.                    | -          |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre  | Descripción                                          |
|---------|------------------------------------------------------|
| `private_dns_resolver_id` | ID del Private DNS Resolver.         |
| `private_dns_resolver_inbound_endpoint_id` | ID del endpoint de entrada. |
| `private_dns_resolver_virtual_network_link` | ID del enlace con la red virtual. |
| `ruleset_id` | ID del conjunto de reglas de reenvío de DNS.   |
| `ruleset_name` | Nombre del conjunto de reglas de reenvío.   |

## Uso

Ejemplo de uso del módulo:

```hcl
module "private_dns_resolver" {
  source                      = "./ruta/al/modulo"
  name                        = "mi-dns-resolver"
  resource_group_name         = "mi-grupo-de-recursos"
  location                    = "East US"
  virtual_network_id          = "vnet-id"
  tags                        = { env = "prod" }
  name_outbound               = "outbound-endpoint"
  subnet_id_outbound          = "subnet-outbound-id"
  name_inbound                = "inbound-endpoint"
  private_ip                  = "10.0.0.10"
  subnet_id_inbound           = "subnet-inbound-id"
  name_forwarding_ruleset     = "dns-forwarding-ruleset"
  name_virtual_network_link   = "vnet-link"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de Private DNS Resolver en Azure.
