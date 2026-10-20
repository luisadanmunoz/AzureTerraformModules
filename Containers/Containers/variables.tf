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
# CONTAINER APP ENVIRONMENTS
#############################################################################
variable "container_app_environments" {
  description = "value to set the container app environments"
  type = map(object({
    container_app_environment_name              = string
    resource_group_name                         = optional(string)
    location                                    = string
    dapr_application_insights_connection_string = optional(string)
    infrastructure_resource_group_name          = optional(string)
    infrastructure_subnet_id                    = optional(string)
    internal_load_balancer_enabled              = optional(bool)
    log_analytics_workspace_name                = optional(string)
    log_analytics_workspace_id                  = optional(string)
    logs_destination                            = optional(string)
    mutual_tls_enabled                          = optional(bool)
    public_network_access                       = optional(string)
    zone_redundancy_enabled                     = optional(bool)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    workload_profile = optional(list(object({
      name                  = string
      workload_profile_type = string
      maximum_count         = optional(number)
      minimum_count         = optional(number)
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
# CONTAINER APP ENVIRONMENT STORAGES
#############################################################################
variable "container_app_environment_storages" {
  description = "value to set the container app environment storages"
  type = map(object({
    container_app_environment_storage_name = string
    container_app_environment_name         = optional(string)
    container_app_environment_id           = optional(string)
    account_name                           = optional(string)
    access_key                             = optional(string)
    share_name                             = string
    access_mode                            = string
    nfs_server_url                         = optional(string)
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
# CONTAINER APP ENVIRONMENT DAPR COMPONENTS
#############################################################################
variable "container_app_environment_dapr_components" {
  description = "value to set the container app environment dapr components"
  type = map(object({
    container_app_environment_dapr_component_name = string
    container_app_environment_name                = optional(string)
    container_app_environment_id                  = optional(string)
    component_type                                = string
    version                                       = string
    ignore_errors                                 = optional(bool)
    init_timeout                                  = optional(string)
    metadata = optional(list(object({
      name        = string
      secret_name = optional(string)
      value       = optional(string)
    })))
    scopes = optional(list(string))
    secret = optional(list(object({
      name                = string
      value               = optional(string)
      identity            = optional(string)
      key_vault_secret_id = optional(string)
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
# CONTAINER APP ENVIRONMENT CERTIFICATES
#############################################################################
variable "container_app_environment_certificates" {
  description = "value to set the container app environment certificates"
  type = map(object({
    container_app_environment_certificate_name = string
    container_app_environment_name             = optional(string)
    container_app_environment_id               = optional(string)
    certificate_blob_base64                    = optional(string)
    certificate_password                       = optional(string)
    certificate_key_vault = optional(object({
      identity            = optional(string)
      key_vault_secret_id = string
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
# CONTAINER APP ENVIRONMENT CUSTOM DOMAINS
#############################################################################
variable "container_app_environment_custom_domains" {
  description = "value to set the container app environment custom domains"
  type = map(object({
    container_app_environment_custom_domain_name = string
    container_app_environment_name               = optional(string)
    container_app_environment_id                 = optional(string)
    certificate_blob_base64                      = string
    certificate_password                         = string
    dns_suffix                                   = string
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
# CONTAINER APPS
#############################################################################
variable "container_apps" {
  description = "value to set the container apps"
  type = map(object({
    container_app_name             = string
    resource_group_name            = optional(string)
    container_app_environment_name = optional(string)
    container_app_environment_id   = optional(string)
    revision_mode                  = string
    workload_profile_name          = optional(string)
    max_inactive_revisions         = optional(number)
    dapr = optional(object({
      app_id       = string
      app_port     = optional(number)
      app_protocol = optional(string)
    }))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    ingress = optional(object({
      allow_insecure_connections = optional(bool)
      client_certificate_mode    = optional(string)
      external_enabled           = optional(bool)
      target_port                = number
      exposed_port               = optional(number)
      transport                  = optional(string)
      cors = optional(object({
        allow_credentials_enabled = optional(bool)
        allowed_headers           = optional(list(string))
        allowed_methods           = optional(list(string))
        allowed_origins           = list(string)
        exposed_headers           = optional(list(string))
        max_age_in_seconds        = optional(number)
      }))
      ip_security_restriction = optional(list(object({
        action           = string
        description      = optional(string)
        ip_address_range = string
        name             = string
      })))
      traffic_weight = list(object({
        label           = optional(string)
        latest_revision = optional(bool)
        percentage      = number
        revision_suffix = optional(string)
      }))
    }))
    registry = optional(list(object({
      server               = string
      identity             = optional(string)
      password_secret_name = optional(string)
      username             = optional(string)
    })))
    secret = optional(list(object({
      name                = string
      identity            = optional(string)
      key_vault_secret_id = optional(string)
      value               = optional(string)
    })))
    template = object({
      min_replicas                     = optional(number)
      max_replicas                     = optional(number)
      cooldown_period_in_seconds       = optional(number)
      polling_interval_in_seconds      = optional(number)
      revision_suffix                  = optional(string)
      termination_grace_period_seconds = optional(number)
      azure_queue_scale_rule = optional(list(object({
        name         = string
        queue_length = number
        queue_name   = string
        authentication = list(object({
          secret_name       = string
          trigger_parameter = string
        }))
      })))
      custom_scale_rule = optional(list(object({
        name             = string
        custom_rule_type = string
        metadata         = map(string)
        authentication = optional(list(object({
          secret_name       = string
          trigger_parameter = string
        })))
      })))
      http_scale_rule = optional(list(object({
        name                = string
        concurrent_requests = number
        authentication = optional(list(object({
          secret_name       = string
          trigger_parameter = string
        })))
      })))
      tcp_scale_rule = optional(list(object({
        name                = string
        concurrent_requests = number
        authentication = optional(list(object({
          secret_name       = string
          trigger_parameter = string
        })))
      })))
      init_container = optional(list(object({
        name              = string
        image             = string
        cpu               = optional(number)
        memory            = optional(string)
        args              = optional(list(string))
        command           = optional(list(string))
        ephemeral_storage = optional(string)
        env = optional(list(object({
          name        = string
          secret_name = optional(string)
          value       = optional(string)
        })))
        volume_mounts = optional(list(object({
          name     = string
          path     = string
          sub_path = optional(string)
        })))
      })))
      container = list(object({
        name              = string
        image             = string
        cpu               = number
        memory            = string
        args              = optional(list(string))
        command           = optional(list(string))
        ephemeral_storage = optional(string)
        env = optional(list(object({
          name        = string
          secret_name = optional(string)
          value       = optional(string)
        })))
        liveness_probe = optional(object({
          failure_count_threshold          = optional(number)
          host                             = optional(string)
          initial_delay                    = optional(number)
          interval_seconds                 = optional(number)
          path                             = optional(string)
          port                             = number
          termination_grace_period_seconds = optional(number)
          timeout                          = optional(number)
          transport                        = string
          header = optional(list(object({
            name  = string
            value = string
          })))
        }))
        readiness_probe = optional(object({
          failure_count_threshold = optional(number)
          host                    = optional(string)
          initial_delay           = optional(number)
          interval_seconds        = optional(number)
          path                    = optional(string)
          port                    = number
          success_count_threshold = optional(number)
          timeout                 = optional(number)
          transport               = string
          header = optional(list(object({
            name  = string
            value = string
          })))
        }))
        startup_probe = optional(object({
          failure_count_threshold          = optional(number)
          host                             = optional(string)
          initial_delay                    = optional(number)
          interval_seconds                 = optional(number)
          path                             = optional(string)
          port                             = number
          termination_grace_period_seconds = optional(number)
          timeout                          = optional(number)
          transport                        = string
          header = optional(list(object({
            name  = string
            value = string
          })))
        }))
        volume_mounts = optional(list(object({
          name     = string
          path     = string
          sub_path = optional(string)
        })))
      }))
      volume = optional(list(object({
        name          = string
        storage_name  = optional(string)
        storage_type  = optional(string)
        mount_options = optional(string)
      })))
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
# CONTAINER APP CUSTOM DOMAINS
#############################################################################
variable "container_app_custom_domains" {
  description = "value to set the container app custom domains"
  type = map(object({
    container_app_custom_domain_name           = string
    container_app_name                         = optional(string)
    container_app_id                           = optional(string)
    container_app_environment_certificate_name = optional(string)
    container_app_environment_certificate_id   = optional(string)
    certificate_binding_type                   = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# CONTAINER APP JOBS
#############################################################################
variable "container_app_jobs" {
  description = "value to set the container app jobs"
  type = map(object({
    container_app_job_name         = string
    resource_group_name            = optional(string)
    location                       = string
    container_app_environment_name = optional(string)
    container_app_environment_id   = optional(string)
    workload_profile_name          = optional(string)
    replica_retry_limit            = optional(number)
    replica_timeout_in_seconds     = number
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    registry = optional(list(object({
      server               = string
      identity             = optional(string)
      password_secret_name = optional(string)
      username             = optional(string)
    })))
    secret = optional(list(object({
      name                = string
      identity            = optional(string)
      key_vault_secret_id = optional(string)
      value               = optional(string)
    })))
    manual_trigger_config = optional(object({
      parallelism              = optional(number)
      replica_completion_count = optional(number)
    }))
    event_trigger_config = optional(object({
      parallelism              = optional(number)
      replica_completion_count = optional(number)
      scale = optional(object({
        max_executions              = optional(number)
        min_executions              = optional(number)
        polling_interval_in_seconds = optional(number)
        rules = optional(list(object({
          name             = string
          custom_rule_type = string
          metadata         = map(string)
          authentication = optional(list(object({
            secret_name       = string
            trigger_parameter = string
          })))
        })))
      }))
    }))
    schedule_trigger_config = optional(object({
      cron_expression          = string
      parallelism              = optional(number)
      replica_completion_count = optional(number)
    }))
    template = object({
      init_container = optional(list(object({
        name              = string
        image             = string
        cpu               = optional(number)
        memory            = optional(string)
        args              = optional(list(string))
        command           = optional(list(string))
        ephemeral_storage = optional(string)
        env = optional(list(object({
          name        = string
          secret_name = optional(string)
          value       = optional(string)
        })))
        volume_mounts = optional(list(object({
          name     = string
          path     = string
          sub_path = optional(string)
        })))
      })))
      container = list(object({
        name              = string
        image             = string
        cpu               = number
        memory            = string
        args              = optional(list(string))
        command           = optional(list(string))
        ephemeral_storage = optional(string)
        env = optional(list(object({
          name        = string
          secret_name = optional(string)
          value       = optional(string)
        })))
        liveness_probe = optional(object({
          failure_count_threshold          = optional(number)
          host                             = optional(string)
          initial_delay                    = optional(number)
          interval_seconds                 = optional(number)
          path                             = optional(string)
          port                             = number
          termination_grace_period_seconds = optional(number)
          timeout                          = optional(number)
          transport                        = string
          header = optional(list(object({
            name  = string
            value = string
          })))
        }))
        readiness_probe = optional(object({
          failure_count_threshold = optional(number)
          host                    = optional(string)
          initial_delay           = optional(number)
          interval_seconds        = optional(number)
          path                    = optional(string)
          port                    = number
          success_count_threshold = optional(number)
          timeout                 = optional(number)
          transport               = string
          header = optional(list(object({
            name  = string
            value = string
          })))
        }))
        startup_probe = optional(object({
          failure_count_threshold          = optional(number)
          host                             = optional(string)
          initial_delay                    = optional(number)
          interval_seconds                 = optional(number)
          path                             = optional(string)
          port                             = number
          termination_grace_period_seconds = optional(number)
          timeout                          = optional(number)
          transport                        = string
          header = optional(list(object({
            name  = string
            value = string
          })))
        }))
        volume_mounts = optional(list(object({
          name     = string
          path     = string
          sub_path = optional(string)
        })))
      }))
      volume = optional(list(object({
        name          = string
        storage_name  = optional(string)
        storage_type  = optional(string)
        mount_options = optional(string)
      })))
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
