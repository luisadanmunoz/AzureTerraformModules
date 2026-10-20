# Seguridad Azure con Terraform

Catálogo base de seguridad para Azure siguiendo la misma estructura que `Networking` y `Gobernanza`.

## Módulos incluidos

- `rg`
- `key_vault`
- `key_vault_access_policy`
- `key_vault_certificate`
- `key_vault_key`
- `key_vault_secret`
- `log_analytics_workspace`
- `monitor_diagnostic_setting`
- `security_center_workspace`
- `security_center_contact`
- `security_center_auto_provisioning`
- `security_center_setting`
- `security_center_server_vulnerability_assessments_setting`
- `security_center_server_vulnerability_assessment_virtual_machine`
- `security_center_subscription_pricing`
- `sentinel_log_analytics_workspace_onboarding`
- `sentinel_watchlist`
- `sentinel_watchlist_item`

## Estrategia de uso

- usa `*_name` cuando la dependencia nace dentro de este mismo stack
- usa `*_id` cuando el recurso es externo o cuando quieres ejecutar un ejemplo standalone
- arranca por `rg`
- añade `key_vault` después con `rbac_authorization_enabled` o `access_policies` según tu modelo de autorización
- usa `key_vault_access_policy` solo si no gestionas `access_policies` inline dentro de `key_vault`
- usa `key_vault_certificate` cuando necesites certificados auto-firmados o importados dentro del mismo vault
- añade `key_vault_key` y `key_vault_secret` cuando el vault ya exista en el mismo plan o cuando aportes el `key_vault_id`
- añade `log_analytics_workspace` como base para Microsoft Defender y Sentinel
- usa `monitor_diagnostic_setting` para enviar auditoría y métricas a Log Analytics, Event Hub o Storage
- usa `security_center_workspace` para enlazar el scope con un workspace de Log Analytics
- usa `security_center_contact`, `security_center_auto_provisioning`, `security_center_setting` y `security_center_server_vulnerability_assessments_setting` para la configuración base de Defender for Cloud
- usa `security_center_server_vulnerability_assessment_virtual_machine` cuando el virtual machine ya exista y quieras activar evaluación de vulnerabilidades sobre él
- usa `security_center_subscription_pricing` para habilitar planes de Defender por tipo de recurso
- usa `sentinel_log_analytics_workspace_onboarding` cuando quieras activar Microsoft Sentinel sobre un workspace
- usa `sentinel_watchlist` y `sentinel_watchlist_item` cuando quieras cargar listas de referencia dentro de Sentinel
- usa `network_acls` cuando necesites restringir acceso por IP o subnets ya existentes
- varios recursos de `security_center_*` operan a nivel de suscripción y requieren permisos elevados como `Owner`

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
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | ./modules/key_vault | n/a |
| <a name="module_key_vault_access_policy"></a> [key\_vault\_access\_policy](#module\_key\_vault\_access\_policy) | ./modules/key_vault_access_policy | n/a |
| <a name="module_key_vault_certificate"></a> [key\_vault\_certificate](#module\_key\_vault\_certificate) | ./modules/key_vault_certificate | n/a |
| <a name="module_key_vault_key"></a> [key\_vault\_key](#module\_key\_vault\_key) | ./modules/key_vault_key | n/a |
| <a name="module_key_vault_secret"></a> [key\_vault\_secret](#module\_key\_vault\_secret) | ./modules/key_vault_secret | n/a |
| <a name="module_log_analytics_workspace"></a> [log\_analytics\_workspace](#module\_log\_analytics\_workspace) | ./modules/log_analytics_workspace | n/a |
| <a name="module_monitor_diagnostic_setting"></a> [monitor\_diagnostic\_setting](#module\_monitor\_diagnostic\_setting) | ./modules/monitor_diagnostic_setting | n/a |
| <a name="module_rg"></a> [rg](#module\_rg) | ./modules/rg | n/a |
| <a name="module_security_center_auto_provisioning"></a> [security\_center\_auto\_provisioning](#module\_security\_center\_auto\_provisioning) | ./modules/security_center_auto_provisioning | n/a |
| <a name="module_security_center_contact"></a> [security\_center\_contact](#module\_security\_center\_contact) | ./modules/security_center_contact | n/a |
| <a name="module_security_center_server_vulnerability_assessment_virtual_machine"></a> [security\_center\_server\_vulnerability\_assessment\_virtual\_machine](#module\_security\_center\_server\_vulnerability\_assessment\_virtual\_machine) | ./modules/security_center_server_vulnerability_assessment_virtual_machine | n/a |
| <a name="module_security_center_server_vulnerability_assessments_setting"></a> [security\_center\_server\_vulnerability\_assessments\_setting](#module\_security\_center\_server\_vulnerability\_assessments\_setting) | ./modules/security_center_server_vulnerability_assessments_setting | n/a |
| <a name="module_security_center_setting"></a> [security\_center\_setting](#module\_security\_center\_setting) | ./modules/security_center_setting | n/a |
| <a name="module_security_center_subscription_pricing"></a> [security\_center\_subscription\_pricing](#module\_security\_center\_subscription\_pricing) | ./modules/security_center_subscription_pricing | n/a |
| <a name="module_security_center_workspace"></a> [security\_center\_workspace](#module\_security\_center\_workspace) | ./modules/security_center_workspace | n/a |
| <a name="module_sentinel_log_analytics_workspace_onboarding"></a> [sentinel\_log\_analytics\_workspace\_onboarding](#module\_sentinel\_log\_analytics\_workspace\_onboarding) | ./modules/sentinel_log_analytics_workspace_onboarding | n/a |
| <a name="module_sentinel_watchlist"></a> [sentinel\_watchlist](#module\_sentinel\_watchlist) | ./modules/sentinel_watchlist | n/a |
| <a name="module_sentinel_watchlist_item"></a> [sentinel\_watchlist\_item](#module\_sentinel\_watchlist\_item) | ./modules/sentinel_watchlist_item | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_key_vault_access_policies"></a> [key\_vault\_access\_policies](#input\_key\_vault\_access\_policies) | value to set the key vault access policies, do not combine this collection with inline access\_policies in the same key vault | <pre>map(object({<br/>    key_vault_name          = optional(string)<br/>    key_vault_id            = optional(string)<br/>    tenant_id               = string<br/>    object_id               = string<br/>    application_id          = optional(string)<br/>    certificate_permissions = optional(list(string))<br/>    key_permissions         = optional(list(string))<br/>    secret_permissions      = optional(list(string))<br/>    storage_permissions     = optional(list(string))<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_key_vault_certificates"></a> [key\_vault\_certificates](#input\_key\_vault\_certificates) | value to set the key vault certificates | <pre>map(object({<br/>    key_vault_certificate_name = string<br/>    key_vault_name             = optional(string)<br/>    key_vault_id               = optional(string)<br/>    certificate = optional(object({<br/>      contents = string<br/>      password = optional(string)<br/>    }))<br/>    certificate_policy = object({<br/>      issuer_parameters = object({<br/>        name = string<br/>      })<br/>      key_properties = object({<br/>        exportable = bool<br/>        key_type   = string<br/>        reuse_key  = bool<br/>        curve      = optional(string)<br/>        key_size   = optional(number)<br/>      })<br/>      lifetime_actions = optional(list(object({<br/>        action = object({<br/>          action_type = string<br/>        })<br/>        trigger = object({<br/>          days_before_expiry  = optional(number)<br/>          lifetime_percentage = optional(number)<br/>        })<br/>      })))<br/>      secret_properties = object({<br/>        content_type = string<br/>      })<br/>      x509_certificate_properties = object({<br/>        subject            = string<br/>        validity_in_months = number<br/>        key_usage          = list(string)<br/>        extended_key_usage = optional(list(string))<br/>        subject_alternative_names = optional(object({<br/>          dns_names = optional(list(string))<br/>          emails    = optional(list(string))<br/>          upns      = optional(list(string))<br/>        }))<br/>      })<br/>    })<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>    tags = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_key_vault_keys"></a> [key\_vault\_keys](#input\_key\_vault\_keys) | value to set the key vault keys | <pre>map(object({<br/>    key_vault_key_name = string<br/>    key_vault_name     = optional(string)<br/>    key_vault_id       = optional(string)<br/>    key_type           = string<br/>    key_size           = optional(number)<br/>    curve              = optional(string)<br/>    key_opts           = list(string)<br/>    not_before_date    = optional(string)<br/>    expiration_date    = optional(string)<br/>    rotation_policy = optional(object({<br/>      expire_after         = optional(string)<br/>      notify_before_expiry = optional(string)<br/>      automatic = optional(object({<br/>        time_after_creation = optional(string)<br/>        time_before_expiry  = optional(string)<br/>      }))<br/>    }))<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>    tags = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_key_vault_secrets"></a> [key\_vault\_secrets](#input\_key\_vault\_secrets) | value to set the key vault secrets | <pre>map(object({<br/>    key_vault_secret_name = string<br/>    key_vault_name        = optional(string)<br/>    key_vault_id          = optional(string)<br/>    value                 = optional(string)<br/>    value_wo              = optional(string)<br/>    value_wo_version      = optional(number)<br/>    content_type          = optional(string)<br/>    not_before_date       = optional(string)<br/>    expiration_date       = optional(string)<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>    tags = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_key_vaults"></a> [key\_vaults](#input\_key\_vaults) | value to set the key vaults | <pre>map(object({<br/>    key_vault_name                  = string<br/>    resource_group_name             = optional(string)<br/>    location                        = string<br/>    tenant_id                       = string<br/>    sku_name                        = string<br/>    enabled_for_deployment          = optional(bool)<br/>    enabled_for_disk_encryption     = optional(bool)<br/>    enabled_for_template_deployment = optional(bool)<br/>    public_network_access_enabled   = optional(bool)<br/>    purge_protection_enabled        = optional(bool)<br/>    rbac_authorization_enabled      = optional(bool)<br/>    soft_delete_retention_days      = optional(number)<br/>    network_acls = optional(object({<br/>      bypass                     = string<br/>      default_action             = string<br/>      ip_rules                   = optional(list(string))<br/>      virtual_network_subnet_ids = optional(list(string))<br/>    }))<br/>    access_policies = optional(list(object({<br/>      tenant_id               = string<br/>      object_id               = string<br/>      application_id          = optional(string)<br/>      key_permissions         = optional(list(string))<br/>      secret_permissions      = optional(list(string))<br/>      certificate_permissions = optional(list(string))<br/>      storage_permissions     = optional(list(string))<br/>    })))<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>    tags = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_log_analytics_workspaces"></a> [log\_analytics\_workspaces](#input\_log\_analytics\_workspaces) | value to set the log analytics workspaces | <pre>map(object({<br/>    log_analytics_workspace_name            = string<br/>    resource_group_name                     = optional(string)<br/>    location                                = string<br/>    sku                                     = optional(string)<br/>    retention_in_days                       = optional(number)<br/>    daily_quota_gb                          = optional(number)<br/>    reservation_capacity_in_gb_per_day      = optional(number)<br/>    internet_ingestion_enabled              = optional(bool)<br/>    internet_query_enabled                  = optional(bool)<br/>    local_authentication_enabled            = optional(bool)<br/>    allow_resource_only_permissions         = optional(bool)<br/>    cmk_for_query_forced                    = optional(bool)<br/>    data_collection_rule_id                 = optional(string)<br/>    immediate_data_purge_on_30_days_enabled = optional(bool)<br/>    identity = optional(object({<br/>      type         = string<br/>      identity_ids = optional(list(string))<br/>    }))<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>    tags = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_monitor_diagnostic_settings"></a> [monitor\_diagnostic\_settings](#input\_monitor\_diagnostic\_settings) | value to set the monitor diagnostic settings | <pre>map(object({<br/>    monitor_diagnostic_setting_name = string<br/>    target_resource_id              = string<br/>    log_analytics_workspace_name    = optional(string)<br/>    log_analytics_workspace_id      = optional(string)<br/>    log_analytics_destination_type  = optional(string)<br/>    storage_account_id              = optional(string)<br/>    eventhub_authorization_rule_id  = optional(string)<br/>    eventhub_name                   = optional(string)<br/>    partner_solution_id             = optional(string)<br/>    enabled_logs = optional(list(object({<br/>      category       = optional(string)<br/>      category_group = optional(string)<br/>      retention_policy = optional(object({<br/>        enabled = bool<br/>        days    = optional(number)<br/>      }))<br/>    })))<br/>    enabled_metrics = optional(list(object({<br/>      category = string<br/>    })))<br/>    metrics = optional(list(object({<br/>      category = string<br/>      enabled  = optional(bool)<br/>      retention_policy = optional(object({<br/>        enabled = bool<br/>        days    = optional(number)<br/>      }))<br/>    })))<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_resources_groups"></a> [resources\_groups](#input\_resources\_groups) | value to set the resources groups | <pre>map(object({<br/>    resource_group_name = string<br/>    location            = string<br/>    tags                = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_security_center_auto_provisionings"></a> [security\_center\_auto\_provisionings](#input\_security\_center\_auto\_provisionings) | value to set the security center auto provisionings | <pre>map(object({<br/>    auto_provision = string<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_security_center_contacts"></a> [security\_center\_contacts](#input\_security\_center\_contacts) | value to set the security center contacts | <pre>map(object({<br/>    security_center_contact_name = string<br/>    email                        = string<br/>    alert_notifications          = bool<br/>    alerts_to_admins             = bool<br/>    phone                        = optional(string)<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_security_center_server_vulnerability_assessment_virtual_machines"></a> [security\_center\_server\_vulnerability\_assessment\_virtual\_machines](#input\_security\_center\_server\_vulnerability\_assessment\_virtual\_machines) | value to set the security center server vulnerability assessment virtual machines | <pre>map(object({<br/>    virtual_machine_id = string<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_security_center_server_vulnerability_assessments_settings"></a> [security\_center\_server\_vulnerability\_assessments\_settings](#input\_security\_center\_server\_vulnerability\_assessments\_settings) | value to set the security center server vulnerability assessments settings | <pre>map(object({<br/>    vulnerability_assessment_provider = string<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_security_center_settings"></a> [security\_center\_settings](#input\_security\_center\_settings) | value to set the security center settings | <pre>map(object({<br/>    setting_name = string<br/>    enabled      = bool<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_security_center_subscription_pricings"></a> [security\_center\_subscription\_pricings](#input\_security\_center\_subscription\_pricings) | value to set the security center subscription pricings | <pre>map(object({<br/>    tier          = string<br/>    resource_type = optional(string)<br/>    subplan       = optional(string)<br/>    extensions = optional(list(object({<br/>      name                            = string<br/>      additional_extension_properties = optional(map(string))<br/>    })))<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_security_center_workspaces"></a> [security\_center\_workspaces](#input\_security\_center\_workspaces) | value to set the security center workspaces | <pre>map(object({<br/>    scope                        = string<br/>    log_analytics_workspace_name = optional(string)<br/>    workspace_id                 = optional(string)<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_sentinel_log_analytics_workspace_onboardings"></a> [sentinel\_log\_analytics\_workspace\_onboardings](#input\_sentinel\_log\_analytics\_workspace\_onboardings) | value to set the sentinel log analytics workspace onboardings | <pre>map(object({<br/>    log_analytics_workspace_name = optional(string)<br/>    workspace_id                 = optional(string)<br/>    customer_managed_key_enabled = optional(bool)<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_sentinel_watchlist_items"></a> [sentinel\_watchlist\_items](#input\_sentinel\_watchlist\_items) | value to set the sentinel watchlist items | <pre>map(object({<br/>    sentinel_watchlist_name = optional(string)<br/>    watchlist_id            = optional(string)<br/>    name                    = optional(string)<br/>    properties              = map(string)<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_sentinel_watchlists"></a> [sentinel\_watchlists](#input\_sentinel\_watchlists) | value to set the sentinel watchlists | <pre>map(object({<br/>    sentinel_watchlist_name      = string<br/>    log_analytics_workspace_name = optional(string)<br/>    log_analytics_workspace_id   = optional(string)<br/>    display_name                 = string<br/>    item_search_key              = string<br/>    default_duration             = optional(string)<br/>    description                  = optional(string)<br/>    labels                       = optional(list(string))<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      read   = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the global tags | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->