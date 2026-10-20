# Terraform Module: Private DNS A Record

Este módulo de Terraform crea un registro A en un Private DNS Zone en Azure.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_private_dns_a_record.private_dns_a_record`: Crea un registro A en un Private DNS Zone.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                | Tipo        | Descripción                                                | Por defecto |
|-----------------------|------------|------------------------------------------------------------|------------|
| `name`               | `string`   | Nombre del registro A.                                     | -          |
| `zone_name`          | `string`   | Nombre del Private DNS Zone.                              | -          |
| `resource_group_name` | `string`   | Nombre del grupo de recursos en el que se desplegará.     | -          |
| `ttl`                | `number`   | Tiempo de vida (TTL) del registro en segundos.            | -          |
| `records`            | `set(string)` | Conjunto de direcciones IP asociadas al registro A.       | -          |

## Uso

Ejemplo de uso del módulo:

```hcl
module "private_dns_a_record" {
  source              = "./ruta/al/modulo"
  name                = "mi-registro-a"
  zone_name           = "privatednszone.com"
  resource_group_name = "mi-grupo-de-recursos"
  ttl                 = 3600
  records             = ["10.0.0.1"]
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de registros A en Private DNS Zone en Azure.