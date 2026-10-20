# Módulo Terraform: IoT Hub DPS

Despliega un `Device Provisioning Service` para IoT.

## Recursos Terraform

- `azurerm_iothub_dps`

## Entradas relevantes

- `iothub_dps_name`
- `resource_group_name`
- `location`
- `allocation_policy`
- `linked_hub`
- `ip_filter_rule`
- `sku`

## Outputs principales

- `id`
- `name`
- `id_scope`
- `device_provisioning_host_name`

## Fuente de referencia

- Terraform Registry: `azurerm_iothub_dps`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_dps
