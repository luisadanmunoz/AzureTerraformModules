# Módulo Terraform: IoT Hub Shared Access Policy

Despliega una `Shared Access Policy` sobre un `IoT Hub` existente.

## Recursos Terraform

- `azurerm_iothub_shared_access_policy`

## Restricciones y notas

- al menos un permiso debe estar activo
- `registry_write` exige tambien `registry_read`

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_iothub_shared_access_policy`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_shared_access_policy
