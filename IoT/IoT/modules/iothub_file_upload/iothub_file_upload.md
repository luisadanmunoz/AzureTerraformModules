# Módulo Terraform: IoT Hub File Upload

Despliega la configuracion de `File Upload` sobre un `IoT Hub`.

## Recursos Terraform

- `azurerm_iothub_file_upload`

## Restricciones y notas

- usa este recurso en lugar del bloque inline `file_upload` del `azurerm_iothub`
- `connection_string` y `container_name` son obligatorios

## Outputs principales

- `id`

## Fuente de referencia

- Terraform Registry: `azurerm_iothub_file_upload`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_file_upload
