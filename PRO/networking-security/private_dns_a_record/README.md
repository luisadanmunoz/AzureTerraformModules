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
| [azurerm_private_dns_a_record.private_dns_a_record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | ############################################################################ PRIVATE DNS A RECORD VARIABLES ############################################################################ | `string` | n/a | yes |
| <a name="input_records"></a> [records](#input\_records) | n/a | `set(string)` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | n/a | `number` | n/a | yes |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->