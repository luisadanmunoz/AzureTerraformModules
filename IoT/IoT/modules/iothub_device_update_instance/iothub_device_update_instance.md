# Módulo Terraform: IoT Hub Device Update Instance

Despliega una `Device Update Instance` enlazada a una `Device Update Account` y a un `IoT Hub`.

## Recursos Terraform

- `azurerm_iothub_device_update_instance`

## Dependencias habituales

- `device_update_account_id`
- `iothub_id`

## Entradas relevantes

- `iothub_device_update_instance_name`
- `diagnostic_enabled`
- `diagnostic_storage_account`

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_iothub_device_update_instance`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_device_update_instance
