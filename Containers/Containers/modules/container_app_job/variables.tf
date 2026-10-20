#############################################################################
# VARIABLES CONTAINER APP JOB
#############################################################################
variable "container_app_job_name" {
  description = "value to set the container app job name"
  type        = string
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "location" {
  description = "value to set the location"
  type        = string
}

variable "container_app_environment_id" {
  description = "value to set the container app environment id"
  type        = string
}

variable "workload_profile_name" {
  description = "value to set the workload profile name"
  type        = string
  default     = null
}

variable "replica_retry_limit" {
  description = "value to set the replica retry limit"
  type        = number
  default     = null
}

variable "replica_timeout_in_seconds" {
  description = "value to set the replica timeout in seconds"
  type        = number
}

variable "identity" {
  description = "value to set the identity"
  type = object({
    type         = string
    identity_ids = optional(list(string))
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

variable "manual_trigger_config" {
  description = "value to set the manual trigger configuration"
  type = object({
    parallelism              = optional(number)
    replica_completion_count = optional(number)
  })
  default = null
}

variable "event_trigger_config" {
  description = "value to set the event trigger configuration"
  type = object({
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
  })
  default = null
}

variable "schedule_trigger_config" {
  description = "value to set the schedule trigger configuration"
  type = object({
    cron_expression          = string
    parallelism              = optional(number)
    replica_completion_count = optional(number)
  })
  default = null
}

variable "template" {
  description = "value to set the template"
  type = object({
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
