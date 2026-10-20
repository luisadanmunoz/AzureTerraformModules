#############################################################################
# VARIABLES VIRTUAL DESKTOP WORKSPACE
#############################################################################
variable "virtual_desktop_workspace_name" {
  description = "value to set the virtual desktop workspace name"
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

variable "friendly_name" {
  description = "value to set the friendly name"
  type        = string
  default     = null
}

variable "description" {
  description = "value to set the description"
  type        = string
  default     = null
}

variable "public_network_access_enabled" {
  description = "value to set the public network access enabled flag"
  type        = bool
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
