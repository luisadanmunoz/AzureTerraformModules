################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Availability Set."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Availability Set should exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Optional) The name of the Availability Set. If not provided, a name will be generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for the generated name. Default: 'avail'."
  type        = string
  default     = "avail"
}

variable "workload" {
  description = "(Optional) Workload name for the naming convention."
  type        = string
  default     = "app"
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
# Availability Set Configuration
################################################################################

variable "platform_fault_domain_count" {
  description = "(Optional) Number of fault domains. Default: 2. Max varies by region (2 or 3)."
  type        = number
  default     = 2
}

variable "platform_update_domain_count" {
  description = "(Optional) Number of update domains. Default: 5. Range: 1-20."
  type        = number
  default     = 5

  validation {
    condition     = var.platform_update_domain_count >= 1 && var.platform_update_domain_count <= 20
    error_message = "platform_update_domain_count must be between 1 and 20."
  }
}

variable "proximity_placement_group_id" {
  description = "(Optional) The ID of the Proximity Placement Group. DEPENDENCY: PPG must exist."
  type        = string
  default     = null
}

variable "managed" {
  description = "(Optional) Use managed disks for VMs. Default: true."
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
