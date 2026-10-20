#############################################################################
# VARIABLES CONTAINER APP
#############################################################################
variable "container_app_name" {
  description = "value to set the container app name"
  type        = string
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "container_app_environment_id" {
  description = "value to set the container app environment id"
  type        = string
}

variable "revision_mode" {
  description = "value to set the revision mode"
  type        = string
}

variable "workload_profile_name" {
  description = "value to set the workload profile name"
  type        = string
  default     = null
}

variable "max_inactive_revisions" {
  description = "value to set the max inactive revisions"
  type        = number
  default     = null
}

variable "dapr" {
  description = "value to set the dapr configuration"
  type = object({
    app_id       = string
    app_port     = optional(number)
    app_protocol = optional(string)
  })
  default = null
}

variable "identity" {
  description = "value to set the identity"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "ingress" {
  description = "value to set the ingress configuration"
  type = object({
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
  })
  default = null
}

variable "registry" {
  description = "value to set the registry configuration"
  type = list(object({
    server               = string
    identity             = optional(string)
    password_secret_name = optional(string)
    username             = optional(string)
  }))
  default = null
}

variable "secret" {
  description = "value to set the secret configuration"
  type = list(object({
    name                = string
    identity            = optional(string)
    key_vault_secret_id = optional(string)
    value               = optional(string)
  }))
  default = null
}

variable "template" {
  description = "value to set the template"
  type = object({
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
}

variable "timeouts" {
  description = "value to set the timeouts"
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
