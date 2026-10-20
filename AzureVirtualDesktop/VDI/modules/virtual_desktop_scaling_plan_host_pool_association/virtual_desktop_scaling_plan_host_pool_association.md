# Módulo Terraform: Virtual Desktop Scaling Plan Host Pool Association

Asocia un `Scaling Plan` a un `Host Pool` de Azure Virtual Desktop.

## Recursos Terraform

- `azurerm_virtual_desktop_scaling_plan_host_pool_association`

## Cuándo usarlo

- cuando prefieres gestionar la relacion scaling plan-host pool como recurso separado

## Entradas relevantes

- `scaling_plan_id`
- `host_pool_id`
- `enabled`

## Restricciones y notas

- no conviene gestionar la misma relacion con el bloque inline `host_pool` del scaling plan

## Outputs principales

- `id`

## Fuente de referencia

- Terraform Registry: `azurerm_virtual_desktop_scaling_plan_host_pool_association`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_scaling_plan_host_pool_association
