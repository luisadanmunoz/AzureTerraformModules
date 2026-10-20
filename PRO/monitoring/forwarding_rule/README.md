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
| [azurerm_private_dns_resolver_forwarding_rule.forwarding_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_forwarding_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_dns_forwarding_ruleset"></a> [dns\_forwarding\_ruleset](#input\_dns\_forwarding\_ruleset) | value of the dns forwarding ruleset tag | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | value of the domain name tag | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | value of the enabled tag | `string` | n/a | yes |
| <a name="input_ip_address"></a> [ip\_address](#input\_ip\_address) | value of the ip address tag | `string` | n/a | yes |
| <a name="input_ip_address2"></a> [ip\_address2](#input\_ip\_address2) | value of the ip address2 tag | `string` | n/a | yes |
| <a name="input_name_forwarding_rule"></a> [name\_forwarding\_rule](#input\_name\_forwarding\_rule) | value of the name forwarding rule tag | `string` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | value of the port tag | `string` | n/a | yes |
| <a name="input_port2"></a> [port2](#input\_port2) | value of the port2 tag | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->