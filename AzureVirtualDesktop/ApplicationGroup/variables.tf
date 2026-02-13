################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the AVD Application Group."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Application Group should exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Optional) The name of the Application Group. If not provided, a name will be generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for the generated name. Default: 'vdag'."
  type        = string
  default     = "vdag"
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
# Application Group Configuration
################################################################################

variable "host_pool_id" {
  description = "(Required) The ID of the Host Pool. DEPENDENCY: Host Pool must exist."
  type        = string
}

variable "type" {
  description = "(Required) The type of the Application Group. Values: Desktop, RemoteApp."
  type        = string

  validation {
    condition     = contains(["Desktop", "RemoteApp"], var.type)
    error_message = "type must be either 'Desktop' or 'RemoteApp'."
  }
}

variable "friendly_name" {
  description = "(Optional) A friendly name for the Application Group."
  type        = string
  default     = null
}

variable "description" {
  description = "(Optional) A description for the Application Group."
  type        = string
  default     = null
}

variable "default_desktop_display_name" {
  description = "(Optional) The display name for the default desktop. Only for Desktop type."
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
