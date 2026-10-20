# Módulo Terraform: AI Foundry

Despliega un `AI Foundry Hub` clásico. Este recurso es legacy frente al camino moderno basado en `cognitive_account`.

## Recursos Terraform

- `azurerm_ai_foundry`

## Entradas relevantes

- `ai_foundry_name`
- `resource_group_name`
- `location`
- `storage_account_id`
- `key_vault_id`
- `identity`
- `encryption`

## Restricciones y notas

- requiere `storage_account_id` y `key_vault_id`
- si usas identidad `UserAssigned` junto con `encryption`, debes pasar `encryption.user_assigned_identity_id`
- úsalo solo si necesitas compatibilidad con hub clásico

## Outputs principales

- `id`
- `name`
- `workspace_id`

## Fuente de referencia

- Terraform Registry: `azurerm_ai_foundry`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/ai_foundry
