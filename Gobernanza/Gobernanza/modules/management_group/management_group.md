# Módulo Terraform: Management Group

Despliega un **Azure Management Group** para organizar suscripciones y aplicar gobernanza jerárquica.

## Cuándo usarlo

- para estructurar landing zones
- para aplicar políticas y RBAC a nivel organizativo
- para separar entornos, dominios o unidades de negocio

## Recurso Terraform

- `azurerm_management_group`

## SKU

- no aplica

## Inputs principales

- `management_group_name`
- `display_name`
- `parent_management_group_id`
- `subscription_ids`

## Restricciones relevantes

- Azure no permite management locks sobre management groups
- conviene mantener nombres simples y jerarquías previsibles

## Fuente de referencia

- Terraform Registry: `azurerm_management_group`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group
