# Módulo Terraform: IoT Hub Endpoint Service Bus Queue

Despliega un endpoint de tipo `Service Bus Queue` para un `IoT Hub`.

## Recursos Terraform

- `azurerm_iothub_endpoint_servicebus_queue`

## Restricciones y notas

- `authentication_type = "keyBased"` requiere `connection_string`
- `authentication_type = "identityBased"` requiere `endpoint_uri` y `entity_path`

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_iothub_endpoint_servicebus_queue`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_endpoint_servicebus_queue
