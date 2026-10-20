#############################################################################
# VARIABLES VIRTUAL MACHINE EXTENSION
#############################################################################
variable "virtual_machine_extension_name" {
  description = "value to set the virtual machine extension name"
  type        = string
}

variable "virtual_machine_id" {
  description = "value to set the virtual machine id"
  type        = string
}

variable "publisher" {
  description = "value to set the publisher"
  type        = string
}

variable "type" {
  description = "value to set the type"
  type        = string
}

variable "type_handler_version" {
  description = "value to set the type handler version"
  type        = string
}

variable "auto_upgrade_minor_version" {
  description = "value to set the auto upgrade minor version"
  type        = bool
  default     = null
}

variable "automatic_upgrade_enabled" {
  description = "value to set the automatic upgrade enabled"
  type        = bool
  default     = null
}

variable "failure_suppression_enabled" {
  description = "value to set the failure suppression enabled"
  type        = bool
  default     = null
}

variable "provision_after_extensions" {
  description = "value to set the provision after extensions"
  type        = list(string)
  default     = null
}

variable "settings" {
  description = "value to set the settings"
  type        = any
  default     = null
}

variable "protected_settings" {
  description = "value to set the protected settings"
  type        = any
  default     = null
}

variable "protected_settings_from_key_vault" {
  description = "value to set the protected settings from key vault"
  type = object({
    secret_url      = string
    source_vault_id = string
  })
  default = null
}

variable "timeouts" {
  description = "value to set the timeouts"
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
