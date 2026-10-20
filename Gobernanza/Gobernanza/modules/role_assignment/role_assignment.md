# Módulo Terraform: Role Assignment

Despliega una **asignación RBAC** en Azure para un principal sobre un scope.

## Cuándo usarlo

- para conceder acceso a usuarios, grupos, service principals o managed identities
- para aplicar permisos a nivel de suscripción, resource group o recurso

## Recurso Terraform

- `azurerm_role_assignment`

## SKU

- no aplica

## Inputs principales

- `scope`
- `principal_id`
- `role_definition_name` o `role_definition_id`

## Restricciones y notas

- debes informar solo uno entre `role_definition_name` y `role_definition_id`
- el principal debe existir o el despliegue fallará
- algunos escenarios con service principals recién creados requieren `skip_service_principal_aad_check`

## Fuente de referencia

- Terraform Registry: `azurerm_role_assignment`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
