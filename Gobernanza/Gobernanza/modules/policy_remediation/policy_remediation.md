# Módulo Terraform: Policy Remediation

Despliega una **remediación de política** para corregir recursos no conformes asociados a una policy assignment.

## Recursos Terraform

- `azurerm_management_group_policy_remediation`
- `azurerm_subscription_policy_remediation`
- `azurerm_resource_group_policy_remediation`

## SKU

- no aplica

## Cuándo usarlo

- cuando una política `deployIfNotExists` o `modify` necesita corregir drift
- cuando quieres ejecutar remediación sobre un assignment ya desplegado

## Entradas relevantes

- `remediation_name`
- `scope_type`
- `scope_id`
- `policy_assignment_id`
- `policy_definition_reference_id`

## Restricciones y notas

- depende de una `policy_assignment` previa
- la compatibilidad exacta depende del tipo de política y sus permisos asociados
- suele ser especialmente relevante en políticas con efectos `deployIfNotExists` y `modify`
- SKU: no aplica

## Fuente de referencia

- Terraform Registry: `azurerm_management_group_policy_remediation`, `azurerm_subscription_policy_remediation` y `azurerm_resource_group_policy_remediation`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_remediation
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_remediation
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_remediation
