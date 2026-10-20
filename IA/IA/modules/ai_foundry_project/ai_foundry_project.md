# Módulo Terraform: AI Foundry Project

Despliega un `AI Foundry Project` clásico sobre un `ai_foundry` existente.

## Recursos Terraform

- `azurerm_ai_foundry_project`

## Entradas relevantes

- `ai_foundry_project_name`
- `location`
- `ai_services_hub_id`
- `identity`

## Restricciones y notas

- depende de un `ai_foundry` ya existente
- es parte del modelo legacy de hub clásico

## Outputs principales

- `id`
- `name`
- `project_id`

## Fuente de referencia

- Terraform Registry: `azurerm_ai_foundry_project`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/ai_foundry_project
