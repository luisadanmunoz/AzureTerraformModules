# Módulo Terraform: Container App Environment Dapr Component

Registra un componente Dapr reutilizable dentro del `Container App Environment`.

## Recursos Terraform

- `azurerm_container_app_environment_dapr_component`

## Cuándo usarlo

- cuando quieres publicar state stores, pubsub, bindings o secret stores compartidos
- cuando varias apps del mismo entorno consumen el mismo componente Dapr

## Entradas relevantes

- `container_app_environment_id`
- `component_type`
- `version`
- `metadata`
- `secret`
- `scopes`

## Restricciones y notas

- `scopes` limita qué apps pueden ver el componente
- `metadata` puede llevar `value` o `secret_name` según el componente
- si usas Key Vault, el secreto puede resolverse con `identity` y `key_vault_secret_id`

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_container_app_environment_dapr_component`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_dapr_component
