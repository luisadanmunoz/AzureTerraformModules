# Módulo Terraform: Virtual Desktop Host Pool

Despliega un `Virtual Desktop Host Pool` de Azure Virtual Desktop.

## Recursos Terraform

- `azurerm_virtual_desktop_host_pool`

## Cuándo usarlo

- cuando necesitas definir un pool `Pooled` o `Personal`
- cuando quieres controlar balanceo, RDP properties y actualizaciones de agente

## Entradas relevantes

- `type`
- `load_balancer_type`
- `personal_desktop_assignment_type`
- `maximum_sessions_allowed`
- `scheduled_agent_updates`

## Restricciones y notas

- si `type = "Personal"`, `personal_desktop_assignment_type` es obligatorio
- si `type = "Personal"`, `load_balancer_type` debe ser `Persistent`
- si `type = "Pooled"`, `load_balancer_type` no debe ser `Persistent`
- si habilitas `scheduled_agent_updates`, necesitas entre una y dos ventanas `schedule`

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_virtual_desktop_host_pool`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool
