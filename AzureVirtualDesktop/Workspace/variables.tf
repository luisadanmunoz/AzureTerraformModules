################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the AVD Workspace."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Workspace should exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Optional) The name of the Workspace. If not provided, a name will be generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for the generated name. Default: 'vdws'."
  type        = string
  default     = "vdws"
}

variable "workload" {
  description = "(Optional) Workload name for the naming convention."
  type        = string
  default     = "avd"
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
# Workspace Configuration
################################################################################

variable "friendly_name" {
  description = "(Optional) A friendly name for the Workspace displayed to users."
  type        = string
  default     = null
}

variable "description" {
  description = "(Optional) A description for the Workspace."
  type        = string
  default     = null
}

variable "public_network_access_enabled" {
  description = "(Optional) Whether public network access is enabled. Default: true."
  type        = bool
  default     = true
}

################################################################################
# Application Group Association
################################################################################

variable "application_group_ids" {
  description = "(Optional) List of Application Group IDs to associate. DEPENDENCY: Application Groups must exist."
  type        = list(string)
  default     = []
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
