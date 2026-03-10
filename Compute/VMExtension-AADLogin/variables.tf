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
  description = "(Optional) Extension name. Default: AADSSHLogin or AADLoginForWindows."
  type        = string
  default     = null
}

variable "auto_upgrade_minor_version" {
  description = "(Optional) Auto upgrade minor version. Default: true."
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
