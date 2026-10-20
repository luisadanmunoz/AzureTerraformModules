# Módulo Terraform: IoT Hub Endpoint Storage Container

Despliega un endpoint de tipo `Storage Container` para un `IoT Hub`.

## Recursos Terraform

- `azurerm_iothub_endpoint_storage_container`

## Restricciones y notas

- `authentication_type = "keyBased"` requiere `connection_string`
- `authentication_type = "identityBased"` requiere `endpoint_uri`

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_iothub_endpoint_storage_container`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_endpoint_storage_container
