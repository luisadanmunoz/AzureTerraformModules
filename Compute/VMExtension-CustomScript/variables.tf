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
  description = "(Optional) Extension name. Default: CustomScript."
  type        = string
  default     = "CustomScript"
}

variable "auto_upgrade_minor_version" {
  description = "(Optional) Auto upgrade minor version. Default: true."
  type        = bool
  default     = true
}

variable "automatic_upgrade_enabled" {
  description = "(Optional) Enable automatic upgrade. Default: false."
  type        = bool
  default     = false
}

################################################################################
# Script Configuration - Inline
################################################################################

variable "command_to_execute" {
  description = "(Optional) Command to execute. For Linux use shell commands, for Windows use PowerShell."
  type        = string
  default     = null
}

variable "script" {
  description = "(Optional) Base64-encoded script content."
  type        = string
  default     = null
}

################################################################################
# Script Configuration - From URL
################################################################################

variable "file_uris" {
  description = "(Optional) List of URIs to download scripts/files from."
  type        = list(string)
  default     = []
}

variable "storage_account_name" {
  description = "(Optional) Storage account name for private blob access."
  type        = string
  default     = null
}

variable "storage_account_key" {
  description = "(Optional) Storage account key for private blob access."
  type        = string
  default     = null
  sensitive   = true
}

variable "managed_identity_client_id" {
  description = "(Optional) Managed Identity client ID for blob access."
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
