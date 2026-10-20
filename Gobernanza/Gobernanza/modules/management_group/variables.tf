#############################################################################
# VARIABLES MANAGEMENT GROUP
#############################################################################
variable "management_group_name" {
  description = "value to set the management group name"
  type        = string

  validation {
    condition     = length(trim(var.management_group_name, " ")) > 0
    error_message = "management_group_name must not be empty."
  }
}

variable "display_name" {
  description = "value to set the display name"
  type        = string

  validation {
    condition     = length(trim(var.display_name, " ")) > 0
    error_message = "display_name must not be empty."
  }
}

variable "parent_management_group_id" {
  description = "value to set the parent management group id"
  type        = string
  default     = null
}

variable "subscription_ids" {
  description = "value to set the subscription ids"
  type        = list(string)
  default     = []
}
