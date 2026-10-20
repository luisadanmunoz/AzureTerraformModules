# Módulo Terraform: Policy Assignment

Despliega una **asignación de política o iniciativa** en Azure sobre distintos scopes.

## Recursos Terraform

- `azurerm_management_group_policy_assignment`
- `azurerm_subscription_policy_assignment`
- `azurerm_resource_group_policy_assignment`
- `azurerm_resource_policy_assignment`

## SKU

- no aplica

## Entradas relevantes

- `scope_type`
- `scope_id`
- `policy_assignment_name`
- `policy_definition_id`
- `parameters`
- `identity_type`
- `not_scopes`

## Restricciones y notas

- el nombre de algunas asignaciones, especialmente en management group, tiene límites bajos
- si usas identidad administrada, normalmente necesitarás `location`
- el scope debe existir y ser coherente con el tipo de recurso
- este módulo ya soporta bloque `identity` para `SystemAssigned` y `UserAssigned`

## Fuente de referencia

- Terraform Registry: `azurerm_management_group_policy_assignment`, `azurerm_subscription_policy_assignment`, `azurerm_resource_group_policy_assignment` y `azurerm_resource_policy_assignment`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_assignment
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_policy_assignment
