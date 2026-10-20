# Módulo Terraform: Policy Set Definition

Despliega una **iniciativa de políticas** en Azure agrupando varias policy definitions.

## Recurso Terraform

- `azurerm_policy_set_definition`

## SKU

- no aplica

## Cuándo usarlo

- para empaquetar un baseline de gobierno
- para asignar varias políticas como un único artefacto

## Recomendaciones

- usa `reference_id` legibles
- evita iniciativas excesivamente grandes si luego cuesta operarlas

## Entradas relevantes

- `policy_set_definition_name`
- `display_name`
- `policy_type`
- `management_group_id`
- `parameters`
- `policy_definitions`

## Restricciones y notas

- cada entrada de `policy_definitions` debe apuntar a una policy válida
- una iniciativa simplifica asignación y reporting, pero puede aumentar complejidad operativa si agrupa demasiadas políticas
- SKU: no aplica

## Fuente de referencia

- Terraform Registry: `azurerm_policy_set_definition`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_set_definition
