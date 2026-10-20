# Módulo Terraform: IoT Hub Device Update Account

Despliega una `Device Update Account` para Azure Device Update.

## Recursos Terraform

- `azurerm_iothub_device_update_account`

## Entradas relevantes

- `iothub_device_update_account_name`
- `resource_group_name`
- `location`
- `identity`
- `sku`

## Restricciones y notas

- si `identity.type` incluye `UserAssigned`, debes informar `identity_ids`

## Outputs principales

- `id`
- `name`
- `host_name`

## Fuente de referencia

- Terraform Registry: `azurerm_iothub_device_update_account`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_device_update_account
