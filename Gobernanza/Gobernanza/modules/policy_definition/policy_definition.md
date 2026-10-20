# Módulo Terraform: Policy Definition

Despliega una **definición de política** personalizada en Azure.

## Recurso Terraform

- `azurerm_policy_definition`

## SKU

- no aplica

## Inputs principales

- `policy_definition_name`
- `display_name`
- `policy_type`
- `mode`
- `policy_rule`
- `parameters`

## Recomendaciones

- usa `Custom` para políticas propias
- documenta bien el `effect`
- mantén `metadata.category` para clasificar iniciativas y reporting

## Restricciones y notas

- `policy_rule` y `parameters` deben ser JSON válidos desde la perspectiva del recurso Azure Policy
- `mode` suele ser `All` o `Indexed` según el tipo de evaluación
- SKU: no aplica

## Fuente de referencia

- Terraform Registry: `azurerm_policy_definition`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition
