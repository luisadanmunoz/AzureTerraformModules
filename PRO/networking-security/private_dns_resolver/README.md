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
| [azurerm_private_dns_resolver.private_dns_resolver](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver) | resource |
| [azurerm_private_dns_resolver_dns_forwarding_ruleset.forwarding_ruleset](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_dns_forwarding_ruleset) | resource |
| [azurerm_private_dns_resolver_inbound_endpoint.inbound_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_inbound_endpoint) | resource |
| [azurerm_private_dns_resolver_outbound_endpoint.outbound_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_outbound_endpoint) | resource |
| [azurerm_private_dns_resolver_virtual_network_link.network_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_virtual_network_link) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | ############################################################################ PRIVATE DNS RESOLVER ############################################################################ | `string` | n/a | yes |
| <a name="input_name_forwarding_ruleset"></a> [name\_forwarding\_ruleset](#input\_name\_forwarding\_ruleset) | ############################################################################ PRIVATE DNS RESOLVER - FORWARDING RULESET ############################################################################ | `string` | n/a | yes |
| <a name="input_name_inbound"></a> [name\_inbound](#input\_name\_inbound) | ############################################################################ PRIVATE DNS RESOLVER - INBOUND ENDPOINT ############################################################################ | `map` | `{}` | no |
| <a name="input_name_outbound"></a> [name\_outbound](#input\_name\_outbound) | ############################################################################ PRIVATE DNS RESOLVER - OUTBOUND ENDPOINT ############################################################################ | `string` | n/a | yes |
| <a name="input_name_virtual_network_link"></a> [name\_virtual\_network\_link](#input\_name\_virtual\_network\_link) | ############################################################################ PRIVATE DNS RESOLVER - NETWORK LINK ############################################################################ | `string` | n/a | yes |
| <a name="input_private_ip"></a> [private\_ip](#input\_private\_ip) | n/a | `map` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_subnet_id_inbound"></a> [subnet\_id\_inbound](#input\_subnet\_id\_inbound) | n/a | `map` | `{}` | no |
| <a name="input_subnet_id_outbound"></a> [subnet\_id\_outbound](#input\_subnet\_id\_outbound) | n/a | `map` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_private_dns_resolver_id"></a> [private\_dns\_resolver\_id](#output\_private\_dns\_resolver\_id) | ############################################################################ PRIVATE DNS RESOLVER ############################################################################ |
| <a name="output_private_dns_resolver_inbound_endpoint_id"></a> [private\_dns\_resolver\_inbound\_endpoint\_id](#output\_private\_dns\_resolver\_inbound\_endpoint\_id) | ############################################################################ PRIVATE DNS RESOLVER - INBOUND ENDPOINT ############################################################################ |
| <a name="output_private_dns_resolver_virtual_network_link"></a> [private\_dns\_resolver\_virtual\_network\_link](#output\_private\_dns\_resolver\_virtual\_network\_link) | ############################################################################ PRIVATE DNS RESOLVER - NETWORK LINK ############################################################################ |
| <a name="output_ruleset_id"></a> [ruleset\_id](#output\_ruleset\_id) | ############################################################################ PRIVATE DNS RESOLVER - FORWARDING RULESET ############################################################################ |
| <a name="output_ruleset_name"></a> [ruleset\_name](#output\_ruleset\_name) | n/a |
<!-- END_TF_DOCS -->