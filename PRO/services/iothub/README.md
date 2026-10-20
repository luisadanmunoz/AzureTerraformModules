# Terraform Module: Azure IoT Hub

Este módulo de Terraform crea y configura un Azure IoT Hub con Private Endpoint y Device Update Instance.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_iothub.iothub`: Crea un Azure IoT Hub.
- `azurerm_private_endpoint.private_endpoint`: Configura un Private Endpoint para el IoT Hub.
- `azurerm_iothub_device_update_account.device_update_account`: Crea una cuenta de Device Update en IoT Hub.
- `azurerm_iothub_device_update_instance.device_update_instance`: Crea una instancia de Device Update en IoT Hub.
- `azurerm_private_endpoint.private_endpoint_Device_update`: Configura un Private Endpoint para Device Update.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                      | Tipo        | Descripción                                                | Por defecto |
|-----------------------------|------------|------------------------------------------------------------|------------|
| `name`                      | `string`   | Nombre del IoT Hub.                                       | -          |
| `resource_group_name`       | `string`   | Nombre del grupo de recursos donde se creará el IoT Hub.  | -          |
| `location`                  | `string`   | Ubicación donde se desplegará el IoT Hub.                 | -          |
| `sta_id`                    | `string`   | ID del Storage Account asociado a Device Update.          | -          |
| `connection_string_diag`     | `string`   | Cadena de conexión para diagnóstico de Device Update.     | -          |
| `tags`                      | `map(any)` | Etiquetas opcionales para el recurso.                     | `{}`       |
| `subnet_id`                 | `string`   | ID de la subred donde se configurará el Private Endpoint. | -          |
| `private_dns_zone_ids`      | `string`   | ID de la zona privada de DNS asociada.                    | -          |
| `connection_string_sta`      | `string`   | Cadena de conexión del Storage Account.                   | -          |
| `container_name`            | `string`   | Nombre del contenedor donde se almacenarán los mensajes. | -          |
| `connection_string`         | `string`   | Cadena de conexión del Event Hub asociado.                | -          |

## Outputs

Este módulo no define outputs específicos.

## Uso

Ejemplo de uso del módulo:

```hcl
module "iothub" {
  source                     = "./ruta/al/modulo"
  name                       = "mi-iothub"
  resource_group_name        = "mi-grupo-de-recursos"
  location                   = "East US"
  sta_id                     = "storage-id"
  connection_string_diag     = "diag-connection-string"
  tags                       = { env = "prod" }
  subnet_id                  = "subnet-id"
  private_dns_zone_ids       = "dns-zone-id"
  connection_string_sta      = "storage-connection-string"
  container_name             = "mi-container"
  connection_string          = "eventhub-connection-string"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de Azure IoT Hub con Private Endpoint y Device Update en Azure.

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
| [azurerm_iothub.iothub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub) | resource |
| [azurerm_iothub_device_update_account.device_update_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_device_update_account) | resource |
| [azurerm_iothub_device_update_instance.device_update_instance](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_device_update_instance) | resource |
| [azurerm_private_endpoint.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.private_endpoint_Device_update](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_connection_string"></a> [connection\_string](#input\_connection\_string) | n/a | `map` | `{}` | no |
| <a name="input_connection_string_diag"></a> [connection\_string\_diag](#input\_connection\_string\_diag) | n/a | `map` | `{}` | no |
| <a name="input_connection_string_sta"></a> [connection\_string\_sta](#input\_connection\_string\_sta) | n/a | `map` | `{}` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | n/a | `map` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `map` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `map` | `{}` | no |
| <a name="input_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#input\_private\_dns\_zone\_ids) | n/a | `map` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `map` | `{}` | no |
| <a name="input_sta_id"></a> [sta\_id](#input\_sta\_id) | n/a | `map` | `{}` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `map` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->