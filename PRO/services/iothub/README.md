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
