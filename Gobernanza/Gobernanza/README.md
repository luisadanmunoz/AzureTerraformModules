# Gobernanza Azure con Terraform

Catálogo de módulos Terraform para desplegar capacidades de gobernanza en Azure siguiendo una estructura homogénea:

- llamadas desde el root por tipo de recurso
- módulos desacoplados dentro de `modules/`
- ejemplos de entrada por dominio en `env/`
- referencias internas por `*_name` cuando el recurso lo crea el propio stack
- `*_id` como fallback para integraciones externas o ejemplos aislados

## Estructura

- `versions.tf`: versión mínima de Terraform y provider `azurerm`
- `variables.tf`: contrato tipado del stack root
- `*.tf`: llamadas a módulos por tipo de recurso
- `env/*.tfvars`: ejemplos por módulo y ejemplo integral
- `modules/<modulo>`: implementación de cada módulo con 4 ficheros

## Cómo usarlo

Inicialización:

```powershell
terraform init
```

Validación:

```powershell
terraform validate
```

Plan completo de ejemplo:

```powershell
terraform plan -var-file="env\full.dev.tfvars"
```

## Convenciones

- Usa `*_name` cuando la dependencia la crea este mismo stack.
- Usa `*_id` cuando el recurso ya existe fuera de este estado Terraform o quieres un ejemplo standalone.
- Mantén los nombres cortos en recursos con límites estrictos de Azure, por ejemplo `policy_assignment`.
- Evita hardcodear IDs reales de producción en los ejemplos.
- Usa `tags` globales y solo sobrescribe por recurso cuando sea necesario.

## Módulos incluidos

- `rg`
- `tags`
- `management_group`
- `subscription_placement`
- `role_assignment`
- `resource_lock`
- `diagnostic_settings`
- `budget`
- `policy_definition`
- `policy_set_definition`
- `policy_assignment`
- `policy_exemption`
- `policy_remediation`
- `monitor_action_group`
- `activity_log_alert`
- `resource_provider_registration`

## Resumen de módulos

| Módulo | Finalidad | Dependencias típicas | SKU |
|---|---|---|---|
| `rg` | Crear Resource Groups | Ninguna | No aplica |
| `tags` | Construir mapas de tags | Ninguna | No aplica |
| `management_group` | Crear jerarquía organizativa | Ninguna | No aplica |
| `subscription_placement` | Mover suscripciones a management groups | `management_group` | No aplica |
| `role_assignment` | Asignar RBAC | `rg`, `management_group` o scope externo | No aplica |
| `resource_lock` | Proteger recursos frente a borrado o escritura | `rg` o scope externo | No aplica |
| `diagnostic_settings` | Enviar logs y métricas a destinos de monitorización | Recurso destino externo o existente | No aplica |
| `budget` | Control de gasto | `management_group`, `rg` o suscripción | No aplica |
| `policy_definition` | Definir políticas custom | Ninguna | No aplica |
| `policy_set_definition` | Agrupar políticas en iniciativas | `policy_definition` o IDs externos | No aplica |
| `policy_assignment` | Asignar políticas o iniciativas | `management_group`, `rg`, `policy_definition`, `policy_set_definition` | No aplica |
| `policy_exemption` | Crear excepciones | `policy_assignment` | No aplica |
| `policy_remediation` | Ejecutar remediación | `policy_assignment` | No aplica |
| `monitor_action_group` | Definir destinos de alertas | `rg` | No aplica |
| `activity_log_alert` | Alertar sobre eventos administrativos | `rg`, `monitor_action_group` | No aplica |
| `resource_provider_registration` | Registrar providers en la suscripción | Ninguna | No aplica |

## Orden recomendado de despliegue

1. `resource_provider_registration`
2. `management_group`
3. `subscription_placement`
4. `rg`
5. `tags`
6. `monitor_action_group`
7. `role_assignment`
8. `resource_lock`
9. `diagnostic_settings`
10. `budget`
11. `policy_definition`
12. `policy_set_definition`
13. `policy_assignment`
14. `policy_exemption`
15. `policy_remediation`

## Relación entre `*_name` y `*_id`

- Usa `*_name` cuando el recurso lo crea este mismo catálogo y quieres enlazar módulos internamente.
- Usa `*_id` cuando el recurso existe fuera de este estado, pertenece a otro stack o quieres ejecutar un ejemplo sin dependencias previas.
- Si ambos modelos son posibles, prioriza `*_name` y deja `*_id` como fallback operativo.

## Archivos de ejemplo en `env`

- `00-global.dev.tfvars`: base vacía con todas las colecciones
- `full.dev.tfvars`: ejemplo integral de todo el catálogo
- `*.dev.tfvars`: ejemplo individual por módulo o capacidad

## Estrategia recomendada de uso

1. Comienza con `00-global.dev.tfvars` o con el `*.dev.tfvars` del módulo que quieras probar.
2. Lleva primero a `plan` los recursos base: management groups, resource groups y action groups.
3. Añade después gobierno normativo: policy definitions, initiatives y assignments.
4. Usa `policy_exemption` y `policy_remediation` solo cuando ya exista una necesidad operativa real.

## Notas operativas

- `diagnostic_settings` ya está adaptado a `enabled_metric` para evitar problemas con `azurerm` 5.x.
- `activity_log_alert` requiere `location`.
- `policy_remediation` está ajustado al shape real soportado por `azurerm` 4.x.
- El ejemplo `full.dev.tfvars` valida y genera plan completo actualmente.

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
| <a name="module_activity_log_alert"></a> [activity\_log\_alert](#module\_activity\_log\_alert) | ./modules/activity_log_alert | n/a |
| <a name="module_budget"></a> [budget](#module\_budget) | ./modules/budget | n/a |
| <a name="module_diagnostic_settings"></a> [diagnostic\_settings](#module\_diagnostic\_settings) | ./modules/diagnostic_settings | n/a |
| <a name="module_management_group"></a> [management\_group](#module\_management\_group) | ./modules/management_group | n/a |
| <a name="module_monitor_action_group"></a> [monitor\_action\_group](#module\_monitor\_action\_group) | ./modules/monitor_action_group | n/a |
| <a name="module_policy_assignment"></a> [policy\_assignment](#module\_policy\_assignment) | ./modules/policy_assignment | n/a |
| <a name="module_policy_definition"></a> [policy\_definition](#module\_policy\_definition) | ./modules/policy_definition | n/a |
| <a name="module_policy_exemption"></a> [policy\_exemption](#module\_policy\_exemption) | ./modules/policy_exemption | n/a |
| <a name="module_policy_remediation"></a> [policy\_remediation](#module\_policy\_remediation) | ./modules/policy_remediation | n/a |
| <a name="module_policy_set_definition"></a> [policy\_set\_definition](#module\_policy\_set\_definition) | ./modules/policy_set_definition | n/a |
| <a name="module_resource_lock"></a> [resource\_lock](#module\_resource\_lock) | ./modules/resource_lock | n/a |
| <a name="module_resource_provider_registration"></a> [resource\_provider\_registration](#module\_resource\_provider\_registration) | ./modules/resource_provider_registration | n/a |
| <a name="module_rg"></a> [rg](#module\_rg) | ./modules/rg | n/a |
| <a name="module_role_assignment"></a> [role\_assignment](#module\_role\_assignment) | ./modules/role_assignment | n/a |
| <a name="module_subscription_placement"></a> [subscription\_placement](#module\_subscription\_placement) | ./modules/subscription_placement | n/a |
| <a name="module_tags"></a> [tags](#module\_tags) | ./modules/tags | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_activity_log_alerts"></a> [activity\_log\_alerts](#input\_activity\_log\_alerts) | value to set the activity log alerts | <pre>map(object({<br/>    activity_log_alert_name = string<br/>    resource_group_name     = optional(string)<br/>    location                = optional(string)<br/>    scopes                  = list(string)<br/>    operation_name          = optional(string)<br/>    category                = optional(string)<br/>    level                   = optional(string)<br/>    status                  = optional(string)<br/>    action_group_ids        = optional(list(string))<br/>    action_group_names      = optional(list(string))<br/>    description             = optional(string)<br/>    enabled                 = optional(bool)<br/>  }))</pre> | `{}` | no |
| <a name="input_budgets"></a> [budgets](#input\_budgets) | value to set the budgets | <pre>map(object({<br/>    budget_name           = string<br/>    scope_type            = string<br/>    amount                = number<br/>    time_grain            = string<br/>    start_date            = string<br/>    end_date              = optional(string)<br/>    management_group_name = optional(string)<br/>    management_group_id   = optional(string)<br/>    subscription_id       = optional(string)<br/>    resource_group_name   = optional(string)<br/>    resource_group_id     = optional(string)<br/>    notifications = optional(map(object({<br/>      enabled        = bool<br/>      operator       = string<br/>      threshold      = number<br/>      threshold_type = optional(string)<br/>      contact_emails = optional(list(string))<br/>    })))<br/>  }))</pre> | `{}` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | value to set the diagnostic settings | <pre>map(object({<br/>    diagnostic_settings_name       = string<br/>    target_resource_id             = string<br/>    log_analytics_workspace_id     = optional(string)<br/>    log_analytics_destination_type = optional(string)<br/>    storage_account_id             = optional(string)<br/>    eventhub_authorization_rule_id = optional(string)<br/>    eventhub_name                  = optional(string)<br/>    log_categories                 = optional(list(string))<br/>    metric_categories              = optional(list(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_management_groups"></a> [management\_groups](#input\_management\_groups) | value to set the management groups | <pre>map(object({<br/>    management_group_name        = string<br/>    display_name                 = string<br/>    parent_management_group_name = optional(string)<br/>    parent_management_group_id   = optional(string)<br/>    subscription_ids             = optional(list(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_monitor_action_groups"></a> [monitor\_action\_groups](#input\_monitor\_action\_groups) | value to set the monitor action groups | <pre>map(object({<br/>    action_group_name   = string<br/>    short_name          = string<br/>    resource_group_name = optional(string)<br/>    enabled             = optional(bool)<br/>    email_receivers = optional(list(object({<br/>      name                    = string<br/>      email_address           = string<br/>      use_common_alert_schema = optional(bool)<br/>    })))<br/>    webhook_receivers = optional(list(object({<br/>      name                    = string<br/>      service_uri             = string<br/>      use_common_alert_schema = optional(bool)<br/>    })))<br/>    arm_role_receivers = optional(list(object({<br/>      name                    = string<br/>      role_id                 = string<br/>      use_common_alert_schema = optional(bool)<br/>    })))<br/>  }))</pre> | `{}` | no |
| <a name="input_policy_assignments"></a> [policy\_assignments](#input\_policy\_assignments) | value to set the policy assignments | <pre>map(object({<br/>    scope_type                 = string<br/>    scope_id                   = optional(string)<br/>    resource_group_name        = optional(string)<br/>    management_group_name      = optional(string)<br/>    policy_assignment_name     = string<br/>    display_name               = optional(string)<br/>    description                = optional(string)<br/>    policy_definition_id       = optional(string)<br/>    policy_definition_name     = optional(string)<br/>    policy_set_definition_name = optional(string)<br/>    parameters                 = optional(any)<br/>    location                   = optional(string)<br/>    identity_type              = optional(string)<br/>    identity_ids               = optional(list(string))<br/>    not_scopes                 = optional(list(string))<br/>    enforce                    = optional(bool)<br/>    metadata                   = optional(any)<br/>  }))</pre> | `{}` | no |
| <a name="input_policy_definitions"></a> [policy\_definitions](#input\_policy\_definitions) | value to set the policy definitions | <pre>map(object({<br/>    policy_definition_name = string<br/>    display_name           = string<br/>    description            = optional(string)<br/>    policy_type            = optional(string)<br/>    mode                   = optional(string)<br/>    management_group_name  = optional(string)<br/>    management_group_id    = optional(string)<br/>    metadata               = optional(any)<br/>    parameters             = optional(any)<br/>    policy_rule            = any<br/>  }))</pre> | `{}` | no |
| <a name="input_policy_exemptions"></a> [policy\_exemptions](#input\_policy\_exemptions) | value to set the policy exemptions | <pre>map(object({<br/>    scope_type                      = string<br/>    scope_id                        = optional(string)<br/>    resource_group_name             = optional(string)<br/>    management_group_name           = optional(string)<br/>    policy_exemption_name           = string<br/>    policy_assignment_id            = optional(string)<br/>    policy_assignment_name          = optional(string)<br/>    exemption_category              = optional(string)<br/>    display_name                    = optional(string)<br/>    description                     = optional(string)<br/>    expires_on                      = optional(string)<br/>    metadata                        = optional(any)<br/>    policy_definition_reference_ids = optional(list(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_policy_remediations"></a> [policy\_remediations](#input\_policy\_remediations) | value to set the policy remediations | <pre>map(object({<br/>    remediation_name               = string<br/>    scope_type                     = string<br/>    scope_id                       = optional(string)<br/>    resource_group_name            = optional(string)<br/>    management_group_name          = optional(string)<br/>    subscription_id                = optional(string)<br/>    policy_assignment_id           = optional(string)<br/>    policy_assignment_name         = optional(string)<br/>    policy_definition_reference_id = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_policy_set_definitions"></a> [policy\_set\_definitions](#input\_policy\_set\_definitions) | value to set the policy set definitions | <pre>map(object({<br/>    policy_set_definition_name = string<br/>    display_name               = string<br/>    description                = optional(string)<br/>    policy_type                = optional(string)<br/>    management_group_name      = optional(string)<br/>    management_group_id        = optional(string)<br/>    metadata                   = optional(any)<br/>    parameters                 = optional(any)<br/>    policy_definitions = list(object({<br/>      policy_definition_id   = optional(string)<br/>      policy_definition_name = optional(string)<br/>      reference_id           = optional(string)<br/>      parameter_values       = optional(any)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_resource_locks"></a> [resource\_locks](#input\_resource\_locks) | value to set the resource locks | <pre>map(object({<br/>    lock_name             = string<br/>    scope                 = optional(string)<br/>    resource_group_name   = optional(string)<br/>    management_group_name = optional(string)<br/>    lock_level            = string<br/>    notes                 = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_resource_provider_registrations"></a> [resource\_provider\_registrations](#input\_resource\_provider\_registrations) | value to set the resource provider registrations | <pre>map(object({<br/>    resource_provider_name = string<br/>  }))</pre> | `{}` | no |
| <a name="input_resources_groups"></a> [resources\_groups](#input\_resources\_groups) | value to set the resources groups | <pre>map(object({<br/>    resource_group_name = string<br/>    location            = string<br/>    tags                = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments) | value to set the role assignments | <pre>map(object({<br/>    scope                            = optional(string)<br/>    resource_group_name              = optional(string)<br/>    management_group_name            = optional(string)<br/>    principal_id                     = string<br/>    role_definition_name             = optional(string)<br/>    role_definition_id               = optional(string)<br/>    principal_type                   = optional(string)<br/>    description                      = optional(string)<br/>    condition                        = optional(string)<br/>    condition_version                = optional(string)<br/>    skip_service_principal_aad_check = optional(bool)<br/>  }))</pre> | `{}` | no |
| <a name="input_subscription_placements"></a> [subscription\_placements](#input\_subscription\_placements) | value to set the subscriptions placements | <pre>map(object({<br/>    management_group_name = optional(string)<br/>    management_group_id   = optional(string)<br/>    subscription_id       = string<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the global tags | `map(string)` | `{}` | no |
| <a name="input_tags_definitions"></a> [tags\_definitions](#input\_tags\_definitions) | value to set the tags definitions | <pre>map(object({<br/>    workload_name       = string<br/>    environment         = string<br/>    owner               = string<br/>    cost_center         = string<br/>    data_classification = optional(string)<br/>    criticality         = optional(string)<br/>    managed_by          = optional(string)<br/>    custom_tags         = optional(map(string))<br/>  }))</pre> | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->