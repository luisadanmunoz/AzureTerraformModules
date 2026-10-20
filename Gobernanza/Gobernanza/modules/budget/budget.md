# Módulo Terraform: Budget

Despliega un **presupuesto de consumo** en Azure a nivel de management group, suscripción o resource group.

## Recursos Terraform

- `azurerm_consumption_budget_management_group`
- `azurerm_consumption_budget_subscription`
- `azurerm_consumption_budget_resource_group`

## SKU

- no aplica

## Cuándo usarlo

- para control presupuestario por scope
- para lanzar alertas de consumo antes de sobrepasar umbrales
- como complemento de reporting financiero y FinOps

## Entradas relevantes

- `budget_name`
- `scope_type`
- `amount`
- `time_grain`
- `start_date`
- `notifications`

## Restricciones y notas

- el scope debe corresponder con `scope_type`
- los budgets no son un mecanismo de hard stop, sino de control y aviso
- el valor real de notificaciones depende del alcance soportado por el recurso del provider
- en esta versión validada del catálogo el soporte confirmado queda limitado a `contact_emails`

## Fuente de referencia

- Terraform Registry: `azurerm_consumption_budget_management_group`, `azurerm_consumption_budget_subscription` y `azurerm_consumption_budget_resource_group`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_management_group
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_subscription
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_resource_group
