# Módulo Terraform: IoT Hub Endpoint Cosmos DB Account

Despliega un endpoint de tipo `Cosmos DB Account` para un `IoT Hub`.

## Recursos Terraform

- `azurerm_iothub_endpoint_cosmosdb_account`

## Restricciones y notas

- `authentication_type = "keyBased"` requiere al menos `primary_key` o `secondary_key`
- `authentication_type = "identityBased"` no admite `primary_key` ni `secondary_key`

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_iothub_endpoint_cosmosdb_account`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_endpoint_cosmosdb_account
