################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Integration Account."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Integration Account should exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Optional) The name of the Integration Account. If not provided, a name will be generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for the generated name. Default: 'intacc'."
  type        = string
  default     = "intacc"
}

variable "workload" {
  description = "(Optional) Workload name for the naming convention."
  type        = string
  default     = "b2b"
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
# Integration Account Configuration
################################################################################

variable "sku_name" {
  description = "(Optional) The SKU of the Integration Account. Possible values: Free, Basic, Standard. Default: Basic."
  type        = string
  default     = "Basic"

  validation {
    condition     = contains(["Free", "Basic", "Standard"], var.sku_name)
    error_message = "sku_name must be one of: Free, Basic, Standard."
  }
}

variable "integration_service_environment_id" {
  description = "(Optional) The ID of the Integration Service Environment. DEPENDENCY: ISE must exist."
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
