################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the NetApp Capacity Pool. Set to false to disable resource creation without removing module code."
  type        = bool
  default     = true
}

################################################################################
# Required Variables - Dependencies
################################################################################

variable "resource_group_name" {
  description = <<-EOT
    (Required) The name of the Resource Group where the NetApp Capacity Pool will be created.
    DEPENDENCY: Resource Group must exist before creating the NetApp Capacity Pool.
  EOT
  type        = string

  validation {
    condition     = var.resource_group_name != null && var.resource_group_name != ""
    error_message = "resource_group_name is required and cannot be empty."
  }
}

variable "location" {
  description = <<-EOT
    (Required) The Azure region where the NetApp Capacity Pool will be deployed.
    DEPENDENCY: Should match the Resource Group and NetApp Account location.
  EOT
  type        = string

  validation {
    condition     = var.location != null && var.location != ""
    error_message = "location is required and cannot be empty."
  }
}

variable "account_name" {
  description = <<-EOT
    (Required) The name of the NetApp Account in which to create the Capacity Pool.
    DEPENDENCY: NetApp Account must exist before creating the Capacity Pool.
  EOT
  type        = string

  validation {
    condition     = var.account_name != null && var.account_name != ""
    error_message = "account_name is required and cannot be empty."
  }
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) The explicit name for the NetApp Capacity Pool. If provided, overrides name_prefix/workload/environment/instance logic."
  type        = string
  default     = null

  validation {
    condition     = var.name == null || can(regex("^[a-zA-Z0-9][a-zA-Z0-9_-]{0,63}$", var.name))
    error_message = "NetApp Capacity Pool name must be 1-64 characters, start with alphanumeric, and contain only alphanumeric, hyphens, and underscores."
  }
}

variable "name_prefix" {
  description = "(Optional) Prefix to prepend to the generated NetApp Capacity Pool name. Used when 'name' is not provided. Default is 'anfpool'."
  type        = string
  default     = "anfpool"
}

variable "workload" {
  description = "(Optional) The workload or application name, used for naming convention."
  type        = string
  default     = "shared"
}

variable "environment" {
  description = "(Optional) The environment name (e.g., dev, staging, prod), used for naming convention."
  type        = string
  default     = "dev"
}

variable "instance" {
  description = "(Optional) Instance number or identifier for naming convention."
  type        = string
  default     = "001"
}

################################################################################
# NetApp Capacity Pool Configuration
################################################################################

variable "size_in_tb" {
  description = <<-EOT
    (Required) Size of the Capacity Pool in TiB.
    Minimum value is 4 TiB. Must be in increments of 1 TiB.
  EOT
  type        = number

  validation {
    condition     = var.size_in_tb >= 4
    error_message = "size_in_tb must be at least 4 TiB."
  }
}

variable "service_level" {
  description = <<-EOT
    (Optional) The service level of the Capacity Pool.
    Valid options are Standard (16 MiB/s per TiB), Premium (64 MiB/s per TiB), or Ultra (128 MiB/s per TiB).
    Default is Standard.
  EOT
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium", "Ultra"], var.service_level)
    error_message = "service_level must be one of: 'Standard', 'Premium', or 'Ultra'."
  }
}

variable "qos_type" {
  description = <<-EOT
    (Optional) The QoS type of the Capacity Pool.
    Valid options are Auto (QoS based on volume throughput and size) or Manual (QoS manually set per volume).
    Default is Auto.
  EOT
  type        = string
  default     = "Auto"

  validation {
    condition     = contains(["Auto", "Manual"], var.qos_type)
    error_message = "qos_type must be one of: 'Auto' or 'Manual'."
  }
}

variable "encryption_type" {
  description = <<-EOT
    (Optional) The encryption type of the Capacity Pool.
    Valid options are Single (single encryption) or Double (double encryption).
    If not specified, the platform default will be used.
  EOT
  type        = string
  default     = null

  validation {
    condition     = var.encryption_type == null || contains(["Single", "Double"], var.encryption_type)
    error_message = "encryption_type must be one of: 'Single' or 'Double' if specified."
  }
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A map of tags to assign to the NetApp Capacity Pool."
  type        = map(string)
  default     = {}
}
