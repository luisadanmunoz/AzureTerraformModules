# Módulo Terraform: Activity Log Alert

Despliega una **alerta de Activity Log** en Azure Monitor para eventos de control del plano de gestión.

## Cuándo usarlo

- creación o modificación de `policy assignments`
- cambios RBAC
- operaciones administrativas sensibles
- eventos de estado u operaciones a nivel de suscripción y resource group

## Recurso Terraform

- `azurerm_monitor_activity_log_alert`

## SKU

- no aplica

## Entradas relevantes

- `activity_log_alert_name`
- `scopes`
- `category`
- `operation_name`
- `action_group_ids`

## Restricciones y notas

- `location` es requerida por el provider actual
- se recomienda usar `global` salvo necesidad explícita distinta
- puedes asociar varios action groups para notificación o integración

## Fuente de referencia

- Terraform Registry: `azurerm_monitor_activity_log_alert`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_activity_log_alert
