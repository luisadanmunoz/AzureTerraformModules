################################################################################
# Required Variables
################################################################################

variable "resource_group_name" {
  description = "The name of the resource group where the Container Instance will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the Container Instance will be created."
  type        = string
}

variable "containers" {
  description = "List of containers to deploy in the container group."
  type = list(object({
    name   = string
    image  = string
    cpu    = number
    memory = number
    ports = optional(list(object({
      port     = number
      protocol = optional(string, "TCP")
    })), [])
    environment_variables        = optional(map(string), {})
    secure_environment_variables = optional(map(string), {})
    commands                     = optional(list(string), [])
    volume_mounts = optional(list(object({
      name       = string
      mount_path = string
      read_only  = optional(bool, false)
    })), [])
    liveness_probe = optional(object({
      exec                  = optional(list(string))
      http_get_path         = optional(string)
      http_get_port         = optional(number)
      http_get_scheme       = optional(string)
      initial_delay_seconds = optional(number, 0)
      period_seconds        = optional(number, 10)
      failure_threshold     = optional(number, 3)
      success_threshold     = optional(number, 1)
      timeout_seconds       = optional(number, 1)
    }))
    readiness_probe = optional(object({
      exec                  = optional(list(string))
      http_get_path         = optional(string)
      http_get_port         = optional(number)
      http_get_scheme       = optional(string)
      initial_delay_seconds = optional(number, 0)
      period_seconds        = optional(number, 10)
      failure_threshold     = optional(number, 3)
      success_threshold     = optional(number, 1)
      timeout_seconds       = optional(number, 1)
    }))
  }))
}

################################################################################
# Optional Variables - Naming
################################################################################

variable "name" {
  description = "The name of the Container Group. If not provided, will be generated from naming variables."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix for the Container Group name."
  type        = string
  default     = "ci"
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

variable "os_type" {
  description = "The OS type for the container group. Possible values are Linux and Windows."
  type        = string
  default     = "Linux"

  validation {
    condition     = contains(["Linux", "Windows"], var.os_type)
    error_message = "OS type must be Linux or Windows."
  }
}

variable "restart_policy" {
  description = "The restart policy for the container group. Possible values are Always, Never, OnFailure."
  type        = string
  default     = "Always"

  validation {
    condition     = contains(["Always", "Never", "OnFailure"], var.restart_policy)
    error_message = "Restart policy must be Always, Never, or OnFailure."
  }
}

variable "ip_address_type" {
  description = "The IP address type. Possible values are Public, Private, or None."
  type        = string
  default     = "None"

  validation {
    condition     = contains(["Public", "Private", "None"], var.ip_address_type)
    error_message = "IP address type must be Public, Private, or None."
  }
}

variable "dns_name_label" {
  description = "The DNS label/name for the container group's public IP (if public). Must be unique within the Azure region."
  type        = string
  default     = null
}

variable "dns_name_label_reuse_policy" {
  description = "The DNS name label reuse policy. Possible values are Unsecure, TenantReuse, SubscriptionReuse, ResourceGroupReuse, or Noreuse."
  type        = string
  default     = "Unsecure"
}

variable "sku" {
  description = "The SKU for the container group. Possible values are Standard and Dedicated."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Dedicated"], var.sku)
    error_message = "SKU must be Standard or Dedicated."
  }
}

variable "priority" {
  description = "The priority of the container group. Possible values are Regular and Spot."
  type        = string
  default     = "Regular"

  validation {
    condition     = contains(["Regular", "Spot"], var.priority)
    error_message = "Priority must be Regular or Spot."
  }
}

################################################################################
# Optional Variables - Network
################################################################################

variable "subnet_ids" {
  description = "List of subnet IDs for the container group (for Private IP address type)."
  type        = list(string)
  default     = []
}

variable "dns_servers" {
  description = "List of DNS servers for the container group."
  type        = list(string)
  default     = []
}

variable "exposed_ports" {
  description = "List of ports to expose on the container group level."
  type = list(object({
    port     = number
    protocol = optional(string, "TCP")
  }))
  default = []
}

################################################################################
# Optional Variables - Image Registry
################################################################################

variable "image_registry_credential" {
  description = "Image registry credentials for pulling container images."
  type = list(object({
    server                    = string
    username                  = optional(string)
    password                  = optional(string)
    user_assigned_identity_id = optional(string)
  }))
  default = []
}

################################################################################
# Optional Variables - Identity
################################################################################

variable "identity" {
  description = "Managed identity configuration for the container group."
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
# Optional Variables - Volumes
################################################################################

variable "volumes" {
  description = "List of volumes to mount to the container group."
  type = list(object({
    name                 = string
    mount_path           = string
    read_only            = optional(bool, false)
    empty_dir            = optional(bool, false)
    storage_account_name = optional(string)
    storage_account_key  = optional(string)
    share_name           = optional(string)
    secret               = optional(map(string))
    git_repo = optional(object({
      url       = string
      directory = optional(string)
      revision  = optional(string)
    }))
  }))
  default = []
}

################################################################################
# Optional Variables - Diagnostics
################################################################################

variable "diagnostics" {
  description = "Diagnostics configuration for the container group."
  type = object({
    log_analytics = object({
      workspace_id  = string
      workspace_key = string
      log_type      = optional(string, "ContainerInsights")
      metadata      = optional(map(string), {})
    })
  })
  default = null
}

################################################################################
# Optional Variables - Init Containers
################################################################################

variable "init_containers" {
  description = "List of init containers to run before the main containers."
  type = list(object({
    name                         = string
    image                        = string
    environment_variables        = optional(map(string), {})
    secure_environment_variables = optional(map(string), {})
    commands                     = optional(list(string), [])
    volume_mounts = optional(list(object({
      name       = string
      mount_path = string
      read_only  = optional(bool, false)
    })), [])
  }))
  default = []
}

################################################################################
# Optional Variables - Tags
################################################################################

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
