# Módulo Terraform: Cognitive Account Project

Despliega un proyecto moderno sobre una `cognitive_account` de tipo `AIServices`.

## Recursos Terraform

- `azurerm_cognitive_account_project`

## Restricciones y notas

- la cuenta base debe tener `project_management_enabled = true`
- la cuenta base debe tener identidad y `custom_subdomain_name`

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_cognitive_account_project`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account_project
