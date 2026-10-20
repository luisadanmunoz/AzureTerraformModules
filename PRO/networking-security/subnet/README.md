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
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.subnet_nsg_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.assoc-snet-rt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_actions"></a> [actions](#input\_actions) | Lista los service endpoints de servicio si usa service endpoints en valor true | `list(string)` | `[]` | no |
| <a name="input_address_prefixes"></a> [address\_prefixes](#input\_address\_prefixes) | n/a | `list(string)` | n/a | yes |
| <a name="input_default_outbound_access_enabled"></a> [default\_outbound\_access\_enabled](#input\_default\_outbound\_access\_enabled) | n/a | `bool` | n/a | yes |
| <a name="input_enable_delegation"></a> [enable\_delegation](#input\_enable\_delegation) | ############################################################################ SUBNET DELEGATION VARIABLES ############################################################################ | `bool` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | ############################################################################ SUBNET VARIABLES ############################################################################ | `string` | n/a | yes |
| <a name="input_name_delegation"></a> [name\_delegation](#input\_name\_delegation) | n/a | `string` | n/a | yes |
| <a name="input_name_service_delegation"></a> [name\_service\_delegation](#input\_name\_service\_delegation) | n/a | `string` | n/a | yes |
| <a name="input_nsg_assoc"></a> [nsg\_assoc](#input\_nsg\_assoc) | ############################################################################ SUBNET NSG ASSOCIATION ############################################################################ | `bool` | n/a | yes |
| <a name="input_nsg_id"></a> [nsg\_id](#input\_nsg\_id) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_route_table_assoc"></a> [route\_table\_assoc](#input\_route\_table\_assoc) | ############################################################################ SUBNET ROUTE TABLE ASSOCIATION ############################################################################ | `bool` | n/a | yes |
| <a name="input_route_table_id"></a> [route\_table\_id](#input\_route\_table\_id) | n/a | `string` | n/a | yes |
| <a name="input_service_endpoints"></a> [service\_endpoints](#input\_service\_endpoints) | Lista los service endpoints de servicio si usa service endpoints en valor true | `list(string)` | `[]` | no |
| <a name="input_use_actions"></a> [use\_actions](#input\_use\_actions) | Indica si los service endpoints de servicio deben habilitarse. | `bool` | `false` | no |
| <a name="input_use_service_endpoints"></a> [use\_service\_endpoints](#input\_use\_service\_endpoints) | Indica si los service endpoints de servicio deben habilitarse. | `bool` | `false` | no |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ SUBNET OUTPUT ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->