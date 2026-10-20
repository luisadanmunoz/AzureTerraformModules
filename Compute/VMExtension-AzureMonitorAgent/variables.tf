################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the extension."
  type        = bool
  default     = true
}

variable "virtual_machine_id" {
  description = "(Required) The ID of the Virtual Machine. DEPENDENCY: VM must exist."
  type        = string
}

variable "os_type" {
  description = "(Required) OS type. Values: Linux, Windows."
  type        = string

  validation {
    condition     = contains(["Linux", "Windows"], var.os_type)
    error_message = "os_type must be either 'Linux' or 'Windows'."
  }
}

################################################################################
# Extension Configuration
################################################################################

variable "name" {
  description = "(Optional) Extension name. Default: AzureMonitorAgent."
  type        = string
  default     = "AzureMonitorAgent"
}

variable "auto_upgrade_minor_version" {
  description = "(Optional) Auto upgrade minor version. Default: true."
  type        = bool
  default     = true
}

variable "automatic_upgrade_enabled" {
  description = "(Optional) Enable automatic upgrade. Default: true."
  type        = bool
  default     = true
}

################################################################################
# AMA Configuration
################################################################################

variable "data_collection_rule_id" {
  description = "(Optional) The ID of the Data Collection Rule to associate. DEPENDENCY: DCR must exist."
  type        = string
  default     = null
}

variable "data_collection_endpoint_id" {
  description = "(Optional) The ID of the Data Collection Endpoint. DEPENDENCY: DCE must exist."
  type        = string
  default     = null
}

variable "user_assigned_identity_id" {
  description = "(Optional) User Assigned Identity ID for authentication."
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
