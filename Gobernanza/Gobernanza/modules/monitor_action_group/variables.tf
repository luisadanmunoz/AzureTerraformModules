#############################################################################
# VARIABLES MONITOR ACTION GROUP
#############################################################################
variable "action_group_name" {
  description = "value to set the action group name"
  type        = string

  validation {
    condition     = length(trim(var.action_group_name, " ")) > 0
    error_message = "action_group_name must not be empty."
  }
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string

  validation {
    condition     = length(trim(var.resource_group_name, " ")) > 0
    error_message = "resource_group_name must not be empty."
  }
}

variable "short_name" {
  description = "value to set the short name"
  type        = string

  validation {
    condition     = length(trim(var.short_name, " ")) > 0 && length(var.short_name) <= 12
    error_message = "short_name must not be empty and must be 12 characters or less."
  }
}

variable "enabled" {
  description = "value to set the enabled flag"
  type        = bool
  default     = true
}

variable "email_receivers" {
  description = "value to set the email receivers"
  type = list(object({
    name                    = string
    email_address           = string
    use_common_alert_schema = optional(bool)
  }))
  default = []
}

variable "webhook_receivers" {
  description = "value to set the webhook receivers"
  type = list(object({
    name                    = string
    service_uri             = string
    use_common_alert_schema = optional(bool)
  }))
  default = []
}

variable "arm_role_receivers" {
  description = "value to set the arm role receivers"
  type = list(object({
    name                    = string
    role_id                 = string
    use_common_alert_schema = optional(bool)
  }))
  default = []
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
