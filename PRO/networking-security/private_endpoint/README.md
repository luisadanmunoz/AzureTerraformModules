# Terraform Module: Private Endpoint

Este módulo de Terraform crea y configura un Private Endpoint en Azure para conectar servicios privados dentro de una red virtual.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_private_endpoint.private_endpoint`: Crea un Private Endpoint en Azure.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                              | Tipo    | Descripción                                                      | Por defecto |
|-------------------------------------|--------|------------------------------------------------------------------|------------|
| `name`                              | `string` | Nombre del Private Endpoint.                                     | -          |
| `location`                          | `string` | Ubicación donde se desplegará el Private Endpoint.               | -          |
| `resource_group_name`               | `string` | Nombre del grupo de recursos donde se creará el Private Endpoint. | -          |
| `subnet_id`                         | `string` | ID de la subred donde se desplegará el Private Endpoint.         | -          |
| `custom_network_interface_name`     | `string` | Nombre de la interfaz de red personalizada.                      | -          |
| `name_private_service_connection`   | `string` | Nombre de la conexión de servicio privado.                      | -          |
| `private_connection_resource_alias` | `bool`   | Indica si se usará un alias para la conexión.                    | -          |
| `alias`                             | `string` | Alias del recurso privado si se usa conexión con alias.          | -          |
| `private_connection_resource_id`    | `bool`   | Indica si se usará un ID de recurso para la conexión.           | -          |
| `id`                                | `string` | ID del recurso privado si se usa conexión con ID.                | -          |
| `subresource_names`                 | `bool`   | Indica si se usarán subrecursos en la conexión.                 | -          |
| `subresource`                       | `string` | Nombre del subrecurso si aplica.                                 | -          |

## Uso

Ejemplo de uso del módulo:

```hcl
module "private_endpoint" {
  source                          = "./ruta/al/modulo"
  name                            = "mi-private-endpoint"
  location                        = "East US"
  resource_group_name             = "mi-grupo-de-recursos"
  subnet_id                       = "subnet-id"
  custom_network_interface_name   = "private-endpoint-nic"
  name_private_service_connection = "service-connection"
  private_connection_resource_alias = true
  alias                           = "privateservice.alias"
  private_connection_resource_id  = false
  id                              = ""
  subresource_names               = true
  subresource                     = "subresource-name"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de Private Endpoints en Azure.
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
| [azurerm_private_endpoint.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_alias"></a> [alias](#input\_alias) | n/a | `string` | n/a | yes |
| <a name="input_custom_network_interface_name"></a> [custom\_network\_interface\_name](#input\_custom\_network\_interface\_name) | n/a | `string` | n/a | yes |
| <a name="input_id"></a> [id](#input\_id) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | ############################################################################ PRIVATE ENDPOINT VARIABLES ############################################################################ | `string` | n/a | yes |
| <a name="input_name_private_service_connection"></a> [name\_private\_service\_connection](#input\_name\_private\_service\_connection) | n/a | `string` | n/a | yes |
| <a name="input_private_connection_resource_alias"></a> [private\_connection\_resource\_alias](#input\_private\_connection\_resource\_alias) | n/a | `bool` | n/a | yes |
| <a name="input_private_connection_resource_id"></a> [private\_connection\_resource\_id](#input\_private\_connection\_resource\_id) | n/a | `bool` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | n/a | yes |
| <a name="input_subresource"></a> [subresource](#input\_subresource) | n/a | `string` | n/a | yes |
| <a name="input_subresource_names"></a> [subresource\_names](#input\_subresource\_names) | n/a | `bool` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->