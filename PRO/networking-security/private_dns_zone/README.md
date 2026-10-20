# Terraform Module: Private DNS Zone

Este módulo de Terraform crea una zona DNS privada en Azure y la asocia a una red virtual.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_private_dns_zone.dns_zone`: Crea una zona DNS privada en Azure.
- `azurerm_private_dns_zone_virtual_network_link.dns_zone_virtual_network_link`: Asocia la zona DNS privada con una red virtual.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                | Tipo        | Descripción                                            | Por defecto |
|-----------------------|------------|--------------------------------------------------------|------------|
| `name`               | `string`   | Nombre de la zona DNS privada.                        | -          |
| `resource_group_name` | `string`   | Nombre del grupo de recursos donde se creará la zona. | -          |
| `tags`               | `map(any)` | Etiquetas opcionales para el recurso.                 | `{}`       |
| `virtual_network_id`  | `string`   | ID de la red virtual a la que se asociará la zona.   | -          |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre  | Descripción                      |
|---------|----------------------------------|
| `name`  | Nombre de la zona DNS privada.  |
| `id`    | ID de la zona DNS privada.      |

## Uso

Ejemplo de uso del módulo:

```hcl
module "private_dns_zone" {
  source              = "./ruta/al/modulo"
  name                = "privatednszone.com"
  resource_group_name = "mi-grupo-de-recursos"
  tags               = { env = "prod" }
  virtual_network_id  = "vnet-id"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de Private DNS Zone en Azure.