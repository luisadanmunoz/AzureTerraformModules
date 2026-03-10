################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Proximity Placement Group."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the PPG should exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Optional) The name of the PPG. If not provided, a name will be generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for the generated name. Default: 'ppg'."
  type        = string
  default     = "ppg"
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
# PPG Configuration
################################################################################

variable "allowed_vm_sizes" {
  description = "(Optional) List of allowed VM sizes for the PPG."
  type        = list(string)
  default     = []
}

variable "zone" {
  description = "(Optional) The Availability Zone for the PPG."
  type        = string
  default     = null
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
