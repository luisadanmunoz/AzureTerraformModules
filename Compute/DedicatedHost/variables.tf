################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Dedicated Host."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Host should exist."
  type        = string
}

variable "dedicated_host_group_id" {
  description = "(Required) The ID of the Dedicated Host Group. DEPENDENCY: Host Group must exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Optional) The name of the Dedicated Host."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for the generated name. Default: 'dh'."
  type        = string
  default     = "dh"
}

variable "workload" {
  description = "(Optional) Workload name for the naming convention."
  type        = string
  default     = "host"
}

variable "environment" {
  description = "(Optional) Environment name (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "instance" {
  description = "(Optional) Instance number for the naming convention."
  type        = string
  default     = "001"
}

################################################################################
# Host Configuration
################################################################################

variable "sku_name" {
  description = "(Required) The SKU name of the Dedicated Host (e.g., DSv3-Type1, ESv3-Type1)."
  type        = string
}

variable "platform_fault_domain" {
  description = "(Optional) The fault domain of the host. Default: 0."
  type        = number
  default     = 0
}

variable "auto_replace_on_failure" {
  description = "(Optional) Auto replace on failure. Default: true."
  type        = bool
  default     = true
}

variable "license_type" {
  description = "(Optional) License type. Values: None, Windows_Server_Hybrid, Windows_Server_Perpetual."
  type        = string
  default     = "None"

  validation {
    condition     = contains(["None", "Windows_Server_Hybrid", "Windows_Server_Perpetual"], var.license_type)
    error_message = "license_type must be None, Windows_Server_Hybrid, or Windows_Server_Perpetual."
  }
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
