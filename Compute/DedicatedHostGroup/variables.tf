################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Dedicated Host Group."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Host Group should exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Optional) The name of the Dedicated Host Group."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for the generated name. Default: 'dhg'."
  type        = string
  default     = "dhg"
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
# Host Group Configuration
################################################################################

variable "platform_fault_domain_count" {
  description = "(Required) Number of fault domains. Usually 1, 2, or 3."
  type        = number

  validation {
    condition     = var.platform_fault_domain_count >= 1 && var.platform_fault_domain_count <= 3
    error_message = "platform_fault_domain_count must be between 1 and 3."
  }
}

variable "zone" {
  description = "(Optional) The Availability Zone for the Host Group."
  type        = string
  default     = null
}

variable "automatic_placement_enabled" {
  description = "(Optional) Enable automatic VM placement. Default: true."
  type        = bool
  default     = true
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
