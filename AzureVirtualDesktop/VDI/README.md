# VDI Azure con Terraform

Catalogo reusable de Azure Virtual Desktop siguiendo el mismo patron que `Networking`, `Gobernanza`, `Seguridad`, `Almacenamiento`, `Compute`, `Kubernetes`, `Containers` e `IA`.

## Modulos incluidos

- `rg`
- `virtual_desktop_workspace`
- `virtual_desktop_host_pool`
- `virtual_desktop_host_pool_registration_info`
- `virtual_desktop_application_group`
- `virtual_desktop_application`
- `virtual_desktop_workspace_application_group_association`
- `virtual_desktop_scaling_plan`
- `virtual_desktop_scaling_plan_host_pool_association`

## Estrategia de uso

- usa `*_name` cuando la dependencia nace dentro de este mismo stack
- usa `*_id` cuando el recurso es externo o cuando quieres ejecutar un ejemplo standalone
- usa `virtual_desktop_workspace` como punto de entrada para publicar escritorios y aplicaciones
- usa `virtual_desktop_host_pool` para definir el tipo de pool y su comportamiento
- usa `virtual_desktop_host_pool_registration_info` para obtener el token de registro de session hosts
- usa `virtual_desktop_application_group` y `virtual_desktop_application` para RemoteApp o Desktop
- usa `virtual_desktop_workspace_application_group_association` para publicar un application group dentro del workspace
- usa `virtual_desktop_scaling_plan` y `virtual_desktop_scaling_plan_host_pool_association` para autoscaling de host pools

## Dependencias habituales

- los session hosts no se crean en este stack; normalmente vendran de `Compute`
- el registro de session hosts necesita el token de `virtual_desktop_host_pool_registration_info`
- los scaling plans requieren permisos RBAC previos para el servicio de Azure Virtual Desktop

## Notas practicas

- `virtual_desktop_application` tiene sentido sobre `application_group` de tipo `RemoteApp`
- si el host pool es `Personal`, `personal_desktop_assignment_type` es obligatorio y el balanceador debe ser `Persistent`
- `maximum_sessions_allowed` solo aplica a pools `Pooled`
- `scheduled_agent_updates.enabled = true` exige entre una y dos ventanas `schedule`
- no gestiones la misma relacion scaling plan-host pool a la vez con el bloque inline `host_pool` del scaling plan y con el recurso `virtual_desktop_scaling_plan_host_pool_association`
