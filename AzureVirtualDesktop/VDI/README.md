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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.0, < 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_rg"></a> [rg](#module\_rg) | ./modules/rg | n/a |
| <a name="module_virtual_desktop_application"></a> [virtual\_desktop\_application](#module\_virtual\_desktop\_application) | ./modules/virtual_desktop_application | n/a |
| <a name="module_virtual_desktop_application_group"></a> [virtual\_desktop\_application\_group](#module\_virtual\_desktop\_application\_group) | ./modules/virtual_desktop_application_group | n/a |
| <a name="module_virtual_desktop_host_pool"></a> [virtual\_desktop\_host\_pool](#module\_virtual\_desktop\_host\_pool) | ./modules/virtual_desktop_host_pool | n/a |
| <a name="module_virtual_desktop_host_pool_registration_info"></a> [virtual\_desktop\_host\_pool\_registration\_info](#module\_virtual\_desktop\_host\_pool\_registration\_info) | ./modules/virtual_desktop_host_pool_registration_info | n/a |
| <a name="module_virtual_desktop_scaling_plan"></a> [virtual\_desktop\_scaling\_plan](#module\_virtual\_desktop\_scaling\_plan) | ./modules/virtual_desktop_scaling_plan | n/a |
| <a name="module_virtual_desktop_scaling_plan_host_pool_association"></a> [virtual\_desktop\_scaling\_plan\_host\_pool\_association](#module\_virtual\_desktop\_scaling\_plan\_host\_pool\_association) | ./modules/virtual_desktop_scaling_plan_host_pool_association | n/a |
| <a name="module_virtual_desktop_workspace"></a> [virtual\_desktop\_workspace](#module\_virtual\_desktop\_workspace) | ./modules/virtual_desktop_workspace | n/a |
| <a name="module_virtual_desktop_workspace_application_group_association"></a> [virtual\_desktop\_workspace\_application\_group\_association](#module\_virtual\_desktop\_workspace\_application\_group\_association) | ./modules/virtual_desktop_workspace_application_group_association | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_resources_groups"></a> [resources\_groups](#input\_resources\_groups) | value to set the resources groups | <pre>map(object({<br/>    resource_group_name = string<br/>    location            = string<br/>    tags                = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the global tags | `map(string)` | `{}` | no |
| <a name="input_virtual_desktop_application_groups"></a> [virtual\_desktop\_application\_groups](#input\_virtual\_desktop\_application\_groups) | value to set the virtual desktop application groups | <pre>map(object({<br/>    virtual_desktop_application_group_name = string<br/>    resource_group_name                    = optional(string)<br/>    location                               = string<br/>    type                                   = string<br/>    virtual_desktop_host_pool_name         = optional(string)<br/>    host_pool_id                           = optional(string)<br/>    friendly_name                          = optional(string)<br/>    default_desktop_display_name           = optional(string)<br/>    description                            = optional(string)<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>    tags = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_virtual_desktop_applications"></a> [virtual\_desktop\_applications](#input\_virtual\_desktop\_applications) | value to set the virtual desktop applications | <pre>map(object({<br/>    virtual_desktop_application_name       = string<br/>    virtual_desktop_application_group_name = optional(string)<br/>    application_group_id                   = optional(string)<br/>    friendly_name                          = optional(string)<br/>    description                            = optional(string)<br/>    path                                   = string<br/>    command_line_argument_policy           = string<br/>    command_line_arguments                 = optional(string)<br/>    show_in_portal                         = optional(bool)<br/>    icon_path                              = optional(string)<br/>    icon_index                             = optional(number)<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_virtual_desktop_host_pool_registration_infos"></a> [virtual\_desktop\_host\_pool\_registration\_infos](#input\_virtual\_desktop\_host\_pool\_registration\_infos) | value to set the virtual desktop host pool registration infos | <pre>map(object({<br/>    virtual_desktop_host_pool_name = optional(string)<br/>    hostpool_id                    = optional(string)<br/>    expiration_date                = string<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_virtual_desktop_host_pools"></a> [virtual\_desktop\_host\_pools](#input\_virtual\_desktop\_host\_pools) | value to set the virtual desktop host pools | <pre>map(object({<br/>    virtual_desktop_host_pool_name   = string<br/>    resource_group_name              = optional(string)<br/>    location                         = string<br/>    type                             = string<br/>    load_balancer_type               = string<br/>    friendly_name                    = optional(string)<br/>    description                      = optional(string)<br/>    validate_environment             = optional(bool)<br/>    start_vm_on_connect              = optional(bool)<br/>    custom_rdp_properties            = optional(string)<br/>    personal_desktop_assignment_type = optional(string)<br/>    public_network_access            = optional(string)<br/>    maximum_sessions_allowed         = optional(number)<br/>    preferred_app_group_type         = optional(string)<br/>    vm_template                      = optional(string)<br/>    scheduled_agent_updates = optional(object({<br/>      enabled                   = optional(bool)<br/>      timezone                  = optional(string)<br/>      use_session_host_timezone = optional(bool)<br/>      schedule = optional(list(object({<br/>        day_of_week = string<br/>        hour_of_day = number<br/>      })))<br/>    }))<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>    tags = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_virtual_desktop_scaling_plan_host_pool_associations"></a> [virtual\_desktop\_scaling\_plan\_host\_pool\_associations](#input\_virtual\_desktop\_scaling\_plan\_host\_pool\_associations) | value to set the virtual desktop scaling plan host pool associations | <pre>map(object({<br/>    virtual_desktop_scaling_plan_name = optional(string)<br/>    scaling_plan_id                   = optional(string)<br/>    virtual_desktop_host_pool_name    = optional(string)<br/>    host_pool_id                      = optional(string)<br/>    enabled                           = bool<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_virtual_desktop_scaling_plans"></a> [virtual\_desktop\_scaling\_plans](#input\_virtual\_desktop\_scaling\_plans) | value to set the virtual desktop scaling plans | <pre>map(object({<br/>    virtual_desktop_scaling_plan_name = string<br/>    resource_group_name               = optional(string)<br/>    location                          = string<br/>    time_zone                         = string<br/>    friendly_name                     = optional(string)<br/>    description                       = optional(string)<br/>    exclusion_tag                     = optional(string)<br/>    host_pool = optional(list(object({<br/>      virtual_desktop_host_pool_name = optional(string)<br/>      hostpool_id                    = optional(string)<br/>      scaling_plan_enabled           = bool<br/>    })))<br/>    schedule = list(object({<br/>      name                                 = string<br/>      days_of_week                         = list(string)<br/>      ramp_up_start_time                   = string<br/>      ramp_up_load_balancing_algorithm     = string<br/>      ramp_up_minimum_hosts_percent        = optional(number)<br/>      ramp_up_capacity_threshold_percent   = optional(number)<br/>      peak_start_time                      = string<br/>      peak_load_balancing_algorithm        = string<br/>      ramp_down_start_time                 = string<br/>      ramp_down_load_balancing_algorithm   = string<br/>      ramp_down_minimum_hosts_percent      = number<br/>      ramp_down_force_logoff_users         = bool<br/>      ramp_down_wait_time_minutes          = number<br/>      ramp_down_notification_message       = string<br/>      ramp_down_capacity_threshold_percent = number<br/>      ramp_down_stop_hosts_when            = string<br/>      off_peak_start_time                  = string<br/>      off_peak_load_balancing_algorithm    = string<br/>    }))<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>    tags = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_virtual_desktop_workspace_application_group_associations"></a> [virtual\_desktop\_workspace\_application\_group\_associations](#input\_virtual\_desktop\_workspace\_application\_group\_associations) | value to set the virtual desktop workspace application group associations | <pre>map(object({<br/>    virtual_desktop_workspace_name         = optional(string)<br/>    workspace_id                           = optional(string)<br/>    virtual_desktop_application_group_name = optional(string)<br/>    application_group_id                   = optional(string)<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_virtual_desktop_workspaces"></a> [virtual\_desktop\_workspaces](#input\_virtual\_desktop\_workspaces) | value to set the virtual desktop workspaces | <pre>map(object({<br/>    virtual_desktop_workspace_name = string<br/>    resource_group_name            = optional(string)<br/>    location                       = string<br/>    friendly_name                  = optional(string)<br/>    description                    = optional(string)<br/>    public_network_access_enabled  = optional(bool)<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>    tags = optional(map(string))<br/>  }))</pre> | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->