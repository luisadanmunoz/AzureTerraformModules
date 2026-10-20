# Módulo Terraform: Virtual Desktop Scaling Plan

Despliega un `Virtual Desktop Scaling Plan` para autoscaling de host pools.

## Recursos Terraform

- `azurerm_virtual_desktop_scaling_plan`

## Cuándo usarlo

- cuando quieres automatizar ramp-up, peak, ramp-down y off-peak en AVD
- cuando necesitas una o varias agendas de autoscaling para host pools

## Entradas relevantes

- `time_zone`
- `schedule`
- `host_pool`
- `exclusion_tag`

## Dependencias habituales

- permisos RBAC previos para el servicio de Azure Virtual Desktop
- host pools existentes si decides usar el bloque inline `host_pool`

## Restricciones y notas

- el recurso necesita al menos una ventana `schedule`
- no conviene gestionar la misma relacion host pool-scaling plan con el bloque inline `host_pool` y con `virtual_desktop_scaling_plan_host_pool_association` a la vez
- Scaling Plans siguen sujetos a disponibilidad regional de Azure

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_virtual_desktop_scaling_plan`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_scaling_plan
