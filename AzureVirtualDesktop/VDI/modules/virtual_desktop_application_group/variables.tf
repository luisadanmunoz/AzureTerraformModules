#############################################################################
# VARIABLES VIRTUAL DESKTOP APPLICATION GROUP
#############################################################################
variable "virtual_desktop_application_group_name" {
  description = "value to set the virtual desktop application group name"
  type        = string
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "location" {
  description = "value to set the location"
  type        = string
}

variable "type" {
  description = "value to set the application group type"
  type        = string

  validation {
    condition     = contains(["RemoteApp", "Desktop"], var.type)
    error_message = "type must be RemoteApp or Desktop."
  }
}

variable "host_pool_id" {
  description = "value to set the host pool id"
  type        = string
}

variable "friendly_name" {
  description = "value to set the friendly name"
  type        = string
  default     = null
}

variable "default_desktop_display_name" {
  description = "value to set the default desktop display name"
  type        = string
  default     = null
}

variable "description" {
  description = "value to set the description"
  type        = string
  default     = null
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
