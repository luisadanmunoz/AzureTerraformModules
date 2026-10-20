# Terraform Module: NAT Gateway

Este módulo de Terraform crea y configura un NAT Gateway en Azure para la gestión del tráfico de salida desde una red virtual.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_nat_gateway.nat_gateway`: Crea un NAT Gateway en Azure.
- `azurerm_nat_gateway_public_ip_prefix_association.nat_gateway_public_ip_prefix_association`: Asocia un prefijo de IP pública al NAT Gateway.
- `azurerm_subnet_nat_gateway_association.subnet_nat_gateway_association_2`: Asocia el NAT Gateway a una subred específica.
- `azurerm_public_ip_prefix.public_ip_prefix`: Crea un prefijo de IP pública para el NAT Gateway.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                  | Tipo        | Descripción                                                      | Por defecto |
|-------------------------|------------|------------------------------------------------------------------|------------|
| `name`                  | `string`   | Nombre del NAT Gateway.                                         | -          |
| `location`              | `string`   | Ubicación donde se desplegará el NAT Gateway.                   | -          |
| `resource_group_name`   | `string`   | Nombre del grupo de recursos donde se creará el NAT Gateway.    | -          |
| `tags`                  | `map(any)` | Etiquetas opcionales para el recurso.                           | `{}`       |
| `subnet_id_2`           | `string`   | ID de la segunda subred a la que se asociará el NAT Gateway.    | -          |

## Outputs

Este módulo no define outputs específicos.

## Uso

Ejemplo de uso del módulo:

```hcl
module "nat_gateway" {
  source                = "./ruta/al/modulo"
  name                  = "mi-nat-gateway"
  location              = "East US"
  resource_group_name   = "mi-grupo-de-recursos"
  tags                  = { env = "prod" }
  subnet_id_2           = "subnet-id"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de NAT Gateway en Azure.

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
| [azurerm_nat_gateway.nat_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_nat_gateway_public_ip_prefix_association.nat_gateway_public_ip_prefix_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_prefix_association) | resource |
| [azurerm_public_ip_prefix.public_ip_prefix](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip_prefix) | resource |
| [azurerm_subnet_nat_gateway_association.subnet_nat_gateway_association_2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | ############################################################################ NAT GATEWAY VARIABLES ############################################################################ | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_subnet_id_2"></a> [subnet\_id\_2](#input\_subnet\_id\_2) | ############################################################################ NAT GATEWAY SUBNET ASSOCIATION - 2 ############################################################################ | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->