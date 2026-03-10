################################################################################
# Required Variables
################################################################################

variable "resource_group_name" {
  description = "The name of the resource group where the Container App will be created."
  type        = string
}

variable "container_app_environment_id" {
  description = "The ID of the Container App Environment where the Container App will be deployed."
  type        = string
}

################################################################################
# Optional Variables - Naming
################################################################################

variable "name" {
  description = "The name of the Container App. If not provided, will be generated from naming variables."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix for the Container App name."
  type        = string
  default     = "ca"
}

variable "workload" {
  description = "The workload name for naming convention."
  type        = string
  default     = ""
}

variable "environment" {
  description = "The environment name (dev, staging, prod) for naming convention."
  type        = string
  default     = ""
}

variable "instance" {
  description = "The instance identifier for naming convention."
  type        = string
  default     = "001"
}

################################################################################
# Optional Variables - Configuration
################################################################################

variable "create" {
  description = "Controls whether resources should be created."
  type        = bool
  default     = true
}

variable "revision_mode" {
  description = "The revision mode of the Container App. Possible values are Single and Multiple."
  type        = string
  default     = "Single"

  validation {
    condition     = contains(["Single", "Multiple"], var.revision_mode)
    error_message = "Revision mode must be Single or Multiple."
  }
}

variable "workload_profile_name" {
  description = "The workload profile name to use for the Container App."
  type        = string
  default     = null
}

################################################################################
# Optional Variables - Template
################################################################################

variable "template" {
  description = "The template configuration for the Container App."
  type = object({
    min_replicas    = optional(number, 0)
    max_replicas    = optional(number, 10)
    revision_suffix = optional(string)

    containers = list(object({
      name    = string
      image   = string
      cpu     = number
      memory  = string
      args    = optional(list(string), [])
      command = optional(list(string), [])
      env = optional(list(object({
        name        = string
        value       = optional(string)
        secret_name = optional(string)
      })), [])
      liveness_probe = optional(object({
        transport               = string
        port                    = number
        path                    = optional(string)
        host                    = optional(string)
        initial_delay           = optional(number, 1)
        interval_seconds        = optional(number, 10)
        timeout                 = optional(number, 1)
        failure_count_threshold = optional(number, 3)
        header = optional(list(object({
          name  = string
          value = string
        })), [])
      }))
      readiness_probe = optional(object({
        transport               = string
        port                    = number
        path                    = optional(string)
        host                    = optional(string)
        initial_delay           = optional(number, 0)
        interval_seconds        = optional(number, 10)
        timeout                 = optional(number, 1)
        failure_count_threshold = optional(number, 3)
        success_count_threshold = optional(number, 3)
        header = optional(list(object({
          name  = string
          value = string
        })), [])
      }))
      startup_probe = optional(object({
        transport               = string
        port                    = number
        path                    = optional(string)
        host                    = optional(string)
        initial_delay           = optional(number, 0)
        interval_seconds        = optional(number, 10)
        timeout                 = optional(number, 1)
        failure_count_threshold = optional(number, 3)
        header = optional(list(object({
          name  = string
          value = string
        })), [])
      }))
      volume_mounts = optional(list(object({
        name = string
        path = string
      })), [])
    }))

    init_containers = optional(list(object({
      name    = string
      image   = string
      cpu     = optional(number, 0.25)
      memory  = optional(string, "0.5Gi")
      args    = optional(list(string), [])
      command = optional(list(string), [])
      env = optional(list(object({
        name        = string
        value       = optional(string)
        secret_name = optional(string)
      })), [])
      volume_mounts = optional(list(object({
        name = string
        path = string
      })), [])
    })), [])

    volumes = optional(list(object({
      name         = string
      storage_type = optional(string, "EmptyDir")
      storage_name = optional(string)
    })), [])

    azure_queue_scale_rule = optional(list(object({
      name         = string
      queue_name   = string
      queue_length = number
      authentication = list(object({
        secret_name       = string
        trigger_parameter = string
      }))
    })), [])

    custom_scale_rule = optional(list(object({
      name             = string
      custom_rule_type = string
      metadata         = map(string)
      authentication = optional(list(object({
        secret_name       = string
        trigger_parameter = string
      })), [])
    })), [])

    http_scale_rule = optional(list(object({
      name                = string
      concurrent_requests = number
      authentication = optional(list(object({
        secret_name       = string
        trigger_parameter = string
      })), [])
    })), [])

    tcp_scale_rule = optional(list(object({
      name                = string
      concurrent_requests = number
      authentication = optional(list(object({
        secret_name       = string
        trigger_parameter = string
      })), [])
    })), [])
  })
}

################################################################################
# Optional Variables - Ingress
################################################################################

variable "ingress" {
  description = "Ingress configuration for the Container App."
  type = object({
    allow_insecure_connections = optional(bool, false)
    external_enabled           = optional(bool, true)
    target_port                = number
    exposed_port               = optional(number)
    transport                  = optional(string, "auto")
    traffic_weight = optional(list(object({
      label           = optional(string)
      latest_revision = optional(bool, true)
      revision_suffix = optional(string)
      percentage      = number
    })), [])
    ip_security_restriction = optional(list(object({
      name             = string
      action           = string
      ip_address_range = string
      description      = optional(string)
    })), [])
    cors_policy = optional(object({
      allowed_origins     = list(string)
      allowed_methods     = optional(list(string))
      allowed_headers     = optional(list(string))
      expose_headers      = optional(list(string))
      max_age             = optional(number)
      allow_credentials   = optional(bool, false)
    }))
  })
  default = null
}

################################################################################
# Optional Variables - Dapr
################################################################################

variable "dapr" {
  description = "Dapr configuration for the Container App."
  type = object({
    app_id       = string
    app_port     = optional(number)
    app_protocol = optional(string, "http")
  })
  default = null
}

################################################################################
# Optional Variables - Secrets
################################################################################

variable "secrets" {
  description = "List of secrets for the Container App."
  type = list(object({
    name                = string
    value               = optional(string)
    identity            = optional(string)
    key_vault_secret_id = optional(string)
  }))
  default   = []
  sensitive = true
}

################################################################################
# Optional Variables - Registry
################################################################################

variable "registries" {
  description = "Container registries for pulling images."
  type = list(object({
    server               = string
    username             = optional(string)
    password_secret_name = optional(string)
    identity             = optional(string)
  }))
  default = []
}

################################################################################
# Optional Variables - Identity
################################################################################

variable "identity" {
  description = "Managed identity configuration for the Container App."
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = null

  validation {
    condition     = var.identity == null || contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity.type)
    error_message = "Identity type must be SystemAssigned, UserAssigned, or 'SystemAssigned, UserAssigned'."
  }
}

################################################################################
# Optional Variables - Tags
################################################################################

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
