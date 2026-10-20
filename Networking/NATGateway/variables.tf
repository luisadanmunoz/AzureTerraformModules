################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the NAT Gateway."
  type        = bool
  default     = true
}

################################################################################
# Required Variables - Dependencies
################################################################################

variable "resource_group_name" {
  description = <<-EOT
    (Required) The name of the Resource Group where the NAT Gateway will be created.
    DEPENDENCY: Resource Group must exist.
  EOT
  type        = string

  validation {
    condition     = var.resource_group_name != null && var.resource_group_name != ""
    error_message = "resource_group_name is required."
  }
}

variable "location" {
  description = <<-EOT
    (Required) The Azure region where the NAT Gateway will be deployed.
    DEPENDENCY: Should match the Resource Group location.
  EOT
  type        = string

  validation {
    condition     = var.location != null && var.location != ""
    error_message = "location is required."
  }
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) The explicit name for the NAT Gateway."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for generated name."
  type        = string
  default     = "ng"
}

variable "name_suffix" {
  description = "(Optional) Suffix for generated name."
  type        = string
  default     = ""
}

variable "workload" {
  description = "(Optional) Workload name for naming convention."
  type        = string
  default     = "default"
}

variable "environment" {
  description = "(Optional) Environment name."
  type        = string
  default     = "dev"
}

variable "instance" {
  description = "(Optional) Instance identifier."
  type        = string
  default     = "001"
}

################################################################################
# NAT Gateway Configuration
################################################################################

variable "sku_name" {
  description = "(Optional) The SKU name. Only 'Standard' is supported."
  type        = string
  default     = "Standard"

  validation {
    condition     = var.sku_name == "Standard"
    error_message = "sku_name must be 'Standard'."
  }
}

variable "idle_timeout_in_minutes" {
  description = "(Optional) The idle timeout in minutes (4-120). Default is 4."
  type        = number
  default     = 4

  validation {
    condition     = var.idle_timeout_in_minutes >= 4 && var.idle_timeout_in_minutes <= 120
    error_message = "idle_timeout_in_minutes must be between 4 and 120."
  }
}

variable "zones" {
  description = <<-EOT
    (Optional) List of availability zones for the NAT Gateway.
    NAT Gateway supports a single zone only (e.g., ["1"]).
  EOT
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.zones) <= 1
    error_message = "NAT Gateway only supports a single availability zone."
  }
}

################################################################################
# Public IP Configuration
################################################################################

variable "create_public_ip" {
  description = "(Optional) Create a new Public IP for the NAT Gateway."
  type        = bool
  default     = true
}

variable "public_ip_name" {
  description = "(Optional) Name for the created Public IP. Auto-generated if not provided."
  type        = string
  default     = null
}

variable "public_ip_ids" {
  description = <<-EOT
    (Optional) List of existing Public IP IDs to associate with the NAT Gateway.
    DEPENDENCY: Public IPs must exist and be Standard SKU, Static allocation.
  EOT
  type        = list(string)
  default     = []
}

variable "public_ip_prefix_ids" {
  description = <<-EOT
    (Optional) List of Public IP Prefix IDs to associate with the NAT Gateway.
    DEPENDENCY: Public IP Prefixes must exist.
  EOT
  type        = list(string)
  default     = []
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A map of tags to assign to resources."
  type        = map(string)
  default     = {}
}
