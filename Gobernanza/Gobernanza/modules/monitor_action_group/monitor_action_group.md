# Módulo Terraform: Monitor Action Group

Despliega un **Action Group** de Azure Monitor para enrutar alertas a receptores.

## Recurso Terraform

- `azurerm_monitor_action_group`

## SKU

- no aplica

## Receptores

- el módulo incluye `email_receiver`, `webhook_receiver` y `arm_role_receiver`
- Azure soporta más tipos adicionales, pero este catálogo se centra en los más habituales para gobierno

## Entradas relevantes

- `action_group_name`
- `short_name`
- `enabled`
- `email_receivers`
- `webhook_receivers`
- `arm_role_receivers`

## Restricciones y notas

- `short_name` debe ser corto; en este catálogo se valida a 12 caracteres o menos
- el grupo de acción vive dentro de un Resource Group

## Fuente de referencia

- Terraform Registry: `azurerm_monitor_action_group`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group
