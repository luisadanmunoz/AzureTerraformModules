# Módulo Terraform: IoT Hub

Despliega un `IoT Hub` como recurso base del stack IoT.

## Recursos Terraform

- `azurerm_iothub`

## Entradas relevantes

- `iothub_name`
- `resource_group_name`
- `location`
- `sku`
- `cloud_to_device`
- `identity`
- `network_rule_set`

## Restricciones y notas

- este modulo no expone los bloques inline de `endpoint`, `route`, `enrichment`, `fallback_route` ni `file_upload`
- el stack usa los recursos extraidos `azurerm_iothub_endpoint_*`, `azurerm_iothub_route`, `azurerm_iothub_enrichment`, `azurerm_iothub_fallback_route` y `azurerm_iothub_file_upload`
- si `identity.type` incluye `UserAssigned`, debes informar `identity_ids`

## Outputs principales

- `id`
- `name`
- `hostname`
- `event_hub_events_endpoint`

## Fuente de referencia

- Terraform Registry: `azurerm_iothub`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub
