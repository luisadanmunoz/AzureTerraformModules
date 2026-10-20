# Módulo Terraform: IoT Hub DPS Shared Access Policy

Despliega una `Shared Access Policy` sobre un `Device Provisioning Service`.

## Recursos Terraform

- `azurerm_iothub_dps_shared_access_policy`

## Restricciones y notas

- al menos un permiso debe estar activo
- `enrollment_read` exige `registration_read`
- `registration_write` exige `registration_read`
- `enrollment_write` exige `enrollment_read`, `registration_read` y `registration_write`

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_iothub_dps_shared_access_policy`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_dps_shared_access_policy
