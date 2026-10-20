# Terraform Module: Private DNS Resolver Forwarding Rule

Este módulo de Terraform crea una regla de reenvío en un Private DNS Resolver en Azure.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_private_dns_resolver_forwarding_rule.forwarding_rule`: Crea una regla de reenvío para un Private DNS Resolver en Azure.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                     | Tipo        | Descripción                                                  | Por defecto |
|----------------------------|------------|--------------------------------------------------------------|------------|
| `name_forwarding_rule`     | `string`   | Nombre de la regla de reenvío.                              | -          |
| `dns_forwarding_ruleset`   | `string`   | ID del conjunto de reglas de reenvío de DNS.                | -          |
| `domain_name`              | `string`   | Nombre de dominio al que se aplicará la regla de reenvío.   | -          |
| `enabled`                  | `string`   | Estado de habilitación de la regla.                         | -          |
| `ip_address`               | `string`   | Dirección IP del primer servidor DNS de destino.            | -          |
| `port`                     | `string`   | Puerto del primer servidor DNS de destino.                  | -          |
| `ip_address2`              | `string`   | Dirección IP del segundo servidor DNS de destino.           | -          |
| `port2`                    | `string`   | Puerto del segundo servidor DNS de destino.                 | -          |

## Uso

Ejemplo de uso del módulo:

```hcl
module "forwarding_rule" {
  source                  = "./ruta/al/modulo"
  name_forwarding_rule    = "my-forwarding-rule"
  dns_forwarding_ruleset  = "ruleset-id"
  domain_name             = "example.com"
  enabled                 = "true"
  ip_address              = "192.168.1.1"
  port                    = "53"
  ip_address2             = "192.168.1.2"
  port2                   = "53"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de reglas de reenvío en Private DNS Resolver en Azure.
