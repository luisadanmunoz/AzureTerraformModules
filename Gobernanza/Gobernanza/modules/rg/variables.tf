#############################################################################
# VARIABLES RESOURCE GROUP
#############################################################################
variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string

  validation {
    condition     = length(trim(var.resource_group_name, " ")) > 0 && length(var.resource_group_name) <= 90
    error_message = "resource_group_name must not be empty and must be 90 characters or less."
  }
}

variable "location" {
  description = "value to set the location for the resource group"
  type        = string

  validation {
    condition     = length(trim(var.location, " ")) > 0
    error_message = "location must not be empty."
  }
}

variable "tags" {
  description = "value to set the tags for the resource group"
  type        = map(any)
  default     = {}
}
