#############################################################################
# GLOBAL TAGS
#############################################################################
variable "tags" {
  description = "value to set the global tags"
  type        = map(string)
  default     = {}
}

#############################################################################
# RESOURCE GROUPS
#############################################################################
variable "resources_groups" {
  description = "value to set the resources groups"
  type = map(object({
    resource_group_name = string
    location            = string
    tags                = optional(map(string))
  }))
  default = {}
}

#############################################################################
# KEY VAULTS
#############################################################################
variable "key_vaults" {
  description = "value to set the key vaults"
  type = map(object({
    key_vault_name                  = string
    resource_group_name             = optional(string)
    location                        = string
    tenant_id                       = string
    sku_name                        = string
    enabled_for_deployment          = optional(bool)
    enabled_for_disk_encryption     = optional(bool)
    enabled_for_template_deployment = optional(bool)
    public_network_access_enabled   = optional(bool)
    purge_protection_enabled        = optional(bool)
    rbac_authorization_enabled      = optional(bool)
    soft_delete_retention_days      = optional(number)
    network_acls = optional(object({
      bypass                     = string
      default_action             = string
      ip_rules                   = optional(list(string))
      virtual_network_subnet_ids = optional(list(string))
    }))
    access_policies = optional(list(object({
      tenant_id               = string
      object_id               = string
      application_id          = optional(string)
      key_permissions         = optional(list(string))
      secret_permissions      = optional(list(string))
      certificate_permissions = optional(list(string))
      storage_permissions     = optional(list(string))
    })))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# KEY VAULT KEYS
#############################################################################
variable "key_vault_keys" {
  description = "value to set the key vault keys"
  type = map(object({
    key_vault_key_name = string
    key_vault_name     = optional(string)
    key_vault_id       = optional(string)
    key_type           = string
    key_size           = optional(number)
    curve              = optional(string)
    key_opts           = list(string)
    not_before_date    = optional(string)
    expiration_date    = optional(string)
    rotation_policy = optional(object({
      expire_after         = optional(string)
      notify_before_expiry = optional(string)
      automatic = optional(object({
        time_after_creation = optional(string)
        time_before_expiry  = optional(string)
      }))
    }))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# KEY VAULT SECRETS
#############################################################################
variable "key_vault_secrets" {
  description = "value to set the key vault secrets"
  type = map(object({
    key_vault_secret_name = string
    key_vault_name        = optional(string)
    key_vault_id          = optional(string)
    value                 = optional(string)
    value_wo              = optional(string)
    value_wo_version      = optional(number)
    content_type          = optional(string)
    not_before_date       = optional(string)
    expiration_date       = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# KEY VAULT ACCESS POLICIES
#############################################################################
variable "key_vault_access_policies" {
  description = "value to set the key vault access policies, do not combine this collection with inline access_policies in the same key vault"
  type = map(object({
    key_vault_name          = optional(string)
    key_vault_id            = optional(string)
    tenant_id               = string
    object_id               = string
    application_id          = optional(string)
    certificate_permissions = optional(list(string))
    key_permissions         = optional(list(string))
    secret_permissions      = optional(list(string))
    storage_permissions     = optional(list(string))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# KEY VAULT CERTIFICATES
#############################################################################
variable "key_vault_certificates" {
  description = "value to set the key vault certificates"
  type = map(object({
    key_vault_certificate_name = string
    key_vault_name             = optional(string)
    key_vault_id               = optional(string)
    certificate = optional(object({
      contents = string
      password = optional(string)
    }))
    certificate_policy = object({
      issuer_parameters = object({
        name = string
      })
      key_properties = object({
        exportable = bool
        key_type   = string
        reuse_key  = bool
        curve      = optional(string)
        key_size   = optional(number)
      })
      lifetime_actions = optional(list(object({
        action = object({
          action_type = string
        })
        trigger = object({
          days_before_expiry  = optional(number)
          lifetime_percentage = optional(number)
        })
      })))
      secret_properties = object({
        content_type = string
      })
      x509_certificate_properties = object({
        subject            = string
        validity_in_months = number
        key_usage          = list(string)
        extended_key_usage = optional(list(string))
        subject_alternative_names = optional(object({
          dns_names = optional(list(string))
          emails    = optional(list(string))
          upns      = optional(list(string))
        }))
      })
    })
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# LOG ANALYTICS WORKSPACES
#############################################################################
variable "log_analytics_workspaces" {
  description = "value to set the log analytics workspaces"
  type = map(object({
    log_analytics_workspace_name            = string
    resource_group_name                     = optional(string)
    location                                = string
    sku                                     = optional(string)
    retention_in_days                       = optional(number)
    daily_quota_gb                          = optional(number)
    reservation_capacity_in_gb_per_day      = optional(number)
    internet_ingestion_enabled              = optional(bool)
    internet_query_enabled                  = optional(bool)
    local_authentication_enabled            = optional(bool)
    allow_resource_only_permissions         = optional(bool)
    cmk_for_query_forced                    = optional(bool)
    data_collection_rule_id                 = optional(string)
    immediate_data_purge_on_30_days_enabled = optional(bool)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# MONITOR DIAGNOSTIC SETTINGS
#############################################################################
variable "monitor_diagnostic_settings" {
  description = "value to set the monitor diagnostic settings"
  type = map(object({
    monitor_diagnostic_setting_name = string
    target_resource_id              = string
    log_analytics_workspace_name    = optional(string)
    log_analytics_workspace_id      = optional(string)
    log_analytics_destination_type  = optional(string)
    storage_account_id              = optional(string)
    eventhub_authorization_rule_id  = optional(string)
    eventhub_name                   = optional(string)
    partner_solution_id             = optional(string)
    enabled_logs = optional(list(object({
      category       = optional(string)
      category_group = optional(string)
      retention_policy = optional(object({
        enabled = bool
        days    = optional(number)
      }))
    })))
    enabled_metrics = optional(list(object({
      category = string
    })))
    metrics = optional(list(object({
      category = string
      enabled  = optional(bool)
      retention_policy = optional(object({
        enabled = bool
        days    = optional(number)
      }))
    })))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# SECURITY CENTER WORKSPACES
#############################################################################
variable "security_center_workspaces" {
  description = "value to set the security center workspaces"
  type = map(object({
    scope                        = string
    log_analytics_workspace_name = optional(string)
    workspace_id                 = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# SECURITY CENTER CONTACTS
#############################################################################
variable "security_center_contacts" {
  description = "value to set the security center contacts"
  type = map(object({
    security_center_contact_name = string
    email                        = string
    alert_notifications          = bool
    alerts_to_admins             = bool
    phone                        = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# SECURITY CENTER AUTO PROVISIONINGS
#############################################################################
variable "security_center_auto_provisionings" {
  description = "value to set the security center auto provisionings"
  type = map(object({
    auto_provision = string
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# SECURITY CENTER SETTINGS
#############################################################################
variable "security_center_settings" {
  description = "value to set the security center settings"
  type = map(object({
    setting_name = string
    enabled      = bool
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# SECURITY CENTER SERVER VULNERABILITY ASSESSMENTS SETTINGS
#############################################################################
variable "security_center_server_vulnerability_assessments_settings" {
  description = "value to set the security center server vulnerability assessments settings"
  type = map(object({
    vulnerability_assessment_provider = string
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# SECURITY CENTER SERVER VULNERABILITY ASSESSMENT VIRTUAL MACHINES
#############################################################################
variable "security_center_server_vulnerability_assessment_virtual_machines" {
  description = "value to set the security center server vulnerability assessment virtual machines"
  type = map(object({
    virtual_machine_id = string
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# SECURITY CENTER SUBSCRIPTION PRICINGS
#############################################################################
variable "security_center_subscription_pricings" {
  description = "value to set the security center subscription pricings"
  type = map(object({
    tier          = string
    resource_type = optional(string)
    subplan       = optional(string)
    extensions = optional(list(object({
      name                            = string
      additional_extension_properties = optional(map(string))
    })))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# SENTINEL LOG ANALYTICS WORKSPACE ONBOARDING
#############################################################################
variable "sentinel_log_analytics_workspace_onboardings" {
  description = "value to set the sentinel log analytics workspace onboardings"
  type = map(object({
    log_analytics_workspace_name = optional(string)
    workspace_id                 = optional(string)
    customer_managed_key_enabled = optional(bool)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# SENTINEL WATCHLISTS
#############################################################################
variable "sentinel_watchlists" {
  description = "value to set the sentinel watchlists"
  type = map(object({
    sentinel_watchlist_name      = string
    log_analytics_workspace_name = optional(string)
    log_analytics_workspace_id   = optional(string)
    display_name                 = string
    item_search_key              = string
    default_duration             = optional(string)
    description                  = optional(string)
    labels                       = optional(list(string))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# SENTINEL WATCHLIST ITEMS
#############################################################################
variable "sentinel_watchlist_items" {
  description = "value to set the sentinel watchlist items"
  type = map(object({
    sentinel_watchlist_name = optional(string)
    watchlist_id            = optional(string)
    name                    = optional(string)
    properties              = map(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}
