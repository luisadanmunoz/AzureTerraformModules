# Módulo Terraform: Cognitive Account RAI Policy

Despliega una política de `Responsible AI` sobre una `cognitive_account`.

## Recursos Terraform

- `azurerm_cognitive_account_rai_policy`

## Entradas relevantes

- `cognitive_account_id`
- `base_policy_name`
- `content_filter`

## Restricciones y notas

- `content_filter` es obligatorio y define filtros por `Prompt` o `Completion`
- úsalo junto con despliegues y blocklists para endurecer gobernanza de modelos

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_cognitive_account_rai_policy`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account_rai_policy
