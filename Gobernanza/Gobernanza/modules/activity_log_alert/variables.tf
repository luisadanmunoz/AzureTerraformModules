#############################################################################
# VARIABLES ACTIVITY LOG ALERT
#############################################################################
variable "activity_log_alert_name" {
  description = "value to set the activity log alert name"
  type        = string

  validation {
    condition     = length(trim(var.activity_log_alert_name, " ")) > 0
    error_message = "activity_log_alert_name must not be empty."
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

variable "location" {
  description = "value to set the location"
  type        = string

  validation {
    condition     = length(trim(var.location, " ")) > 0
    error_message = "location must not be empty."
  }
}

variable "scopes" {
  description = "value to set the scopes"
  type        = list(string)
}

variable "operation_name" {
  description = "value to set the operation name"
  type        = string
  default     = null
}

variable "category" {
  description = "value to set the category"
  type        = string
  default     = "Administrative"
}

variable "level" {
  description = "value to set the level"
  type        = string
  default     = null
}

variable "status" {
  description = "value to set the status"
  type        = string
  default     = null
}

variable "action_group_ids" {
  description = "value to set the action group ids"
  type        = list(string)
  default     = []
}

variable "description" {
  description = "value to set the description"
  type        = string
  default     = null
}

variable "enabled" {
  description = "value to set the enabled flag"
  type        = bool
  default     = true
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
