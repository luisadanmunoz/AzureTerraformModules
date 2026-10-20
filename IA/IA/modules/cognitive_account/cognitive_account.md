# Módulo Terraform: Cognitive Account

Despliega una `Cognitive Account` para Azure OpenAI, AIServices y otros servicios cognitivos.

## Recursos Terraform

- `azurerm_cognitive_account`

## Entradas relevantes

- `cognitive_account_name`
- `kind`
- `sku_name`
- `custom_subdomain_name`
- `project_management_enabled`
- `network_acls`
- `identity`

## Restricciones y notas

- `project_management_enabled` solo aplica a `kind = "AIServices"`
- `network_injection` solo aplica a `kind = "AIServices"`
- `custom_subdomain_name` es obligatorio cuando defines `network_acls`
- para Azure OpenAI moderno, este es el recurso base más importante del stack

## Outputs principales

- `id`
- `name`
- `endpoint`

## Fuente de referencia

- Terraform Registry: `azurerm_cognitive_account`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account
