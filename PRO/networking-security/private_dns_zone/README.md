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
| [azurerm_private_dns_zone.dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.dns_zone_virtual_network_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | ############################################################################# PRIVATE DNS ZONE VARIABLES ############################################################################# | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | ############################################################################# PRIVATE DNS ZONE VNET LINK VARIABLES ############################################################################# | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | ############################################################################# PRIVATE DNS ZONE OUTPUTS ############################################################################# |
<!-- END_TF_DOCS -->