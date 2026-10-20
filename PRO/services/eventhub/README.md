# Terraform Module: Azure Event Hub

Este módulo de Terraform crea y configura un Azure Event Hub con un Private Endpoint y una regla de autorización.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_eventhub_namespace.namespace`: Crea un espacio de nombres de Event Hub en Azure.
- `azurerm_eventhub.eventhub`: Crea un Event Hub dentro del espacio de nombres.
- `azurerm_eventhub_authorization_rule.authorization_rule`: Crea una regla de autorización para el Event Hub.
- `azurerm_private_endpoint.private_endpoint`: Configura un Private Endpoint para el Event Hub.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                     | Tipo        | Descripción                                                | Por defecto |
|----------------------------|------------|------------------------------------------------------------|------------|
| `namespace`                | `string`   | Nombre del espacio de nombres del Event Hub.              | -          |
| `location`                 | `string`   | Ubicación donde se desplegará el Event Hub.               | -          |
| `resource_group_name`      | `string`   | Nombre del grupo de recursos donde se creará el Event Hub. | -          |
| `private_dns_zone_ids`     | `string`   | ID de la zona privada de DNS asociada.                    | -          |
| `tags`                     | `map(any)` | Etiquetas opcionales para el recurso.                     | `{}`       |
| `name_eventhub`            | `string`   | Nombre del Event Hub.                                      | -          |
| `subnet_id`                | `string`   | ID de la subred donde se configurará el Private Endpoint. | -          |
| `name_authorization_rule`  | `string`   | Nombre de la regla de autorización.                       | -          |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre  | Descripción                                      |
|---------|--------------------------------------------------|
| `name`  | Nombre del Event Hub.                           |
| `id`    | Cadena de conexión primaria del Event Hub.     |

## Uso

Ejemplo de uso del módulo:

```hcl
module "eventhub" {
  source                   = "./ruta/al/modulo"
  namespace                = "mi-eventhub-namespace"
  location                 = "East US"
  resource_group_name      = "mi-grupo-de-recursos"
  private_dns_zone_ids     = "dns-zone-id"
  tags                     = { env = "prod" }
  name_eventhub            = "mi-eventhub"
  subnet_id                = "subnet-id"
  name_authorization_rule  = "mi-regla-autorizacion"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de Azure Event Hub con Private Endpoint y reglas de autorización en Azure.
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
| [azurerm_eventhub.eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub) | resource |
| [azurerm_eventhub_authorization_rule.authorization_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_authorization_rule) | resource |
| [azurerm_eventhub_namespace.namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) | resource |
| [azurerm_private_endpoint.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name_authorization_rule"></a> [name\_authorization\_rule](#input\_name\_authorization\_rule) | ############################################################################ EVENTHUB AUTHORIZATION RULE ############################################################################ | `string` | n/a | yes |
| <a name="input_name_eventhub"></a> [name\_eventhub](#input\_name\_eventhub) | ############################################################################ EVENTHUB ############################################################################ | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ############################################################################ EVENTHUB NAMESPACE ############################################################################ | `string` | n/a | yes |
| <a name="input_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#input\_private\_dns\_zone\_ids) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `map` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | ############################################################################ EVENTHUB NAMESPACE OUTPUT ############################################################################ |
<!-- END_TF_DOCS -->