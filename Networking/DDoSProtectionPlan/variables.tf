################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the DDoS Protection Plan."
  type        = bool
  default     = true
}

################################################################################
# Required Variables
################################################################################

variable "resource_group_name" {
  description = "(Required) Resource Group name. DEPENDENCY: Must exist."
  type        = string
}

variable "location" {
  description = "(Required) Azure region."
  type        = string
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) Explicit name for the DDoS Protection Plan."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for generated name."
  type        = string
  default     = "ddos"
}

variable "workload" {
  description = "(Optional) Workload name."
  type        = string
  default     = "shared"
}

variable "environment" {
  description = "(Optional) Environment name."
  type        = string
  default     = "prod"
}

variable "instance" {
  description = "(Optional) Instance identifier."
  type        = string
  default     = "001"
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) Tags to assign to resources."
  type        = map(string)
  default     = {}
}
