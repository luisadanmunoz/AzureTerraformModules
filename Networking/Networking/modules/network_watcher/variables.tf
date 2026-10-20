#############################################################################
# VARIABLES NETWORK WATCHER
#############################################################################
variable "network_watcher_name" {
  description = "value to set the network watcher name"
  type        = string

  validation {
    condition     = trimspace(var.network_watcher_name) != ""
    error_message = "network_watcher_name must not be empty."
  }
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "location" {
  description = "value to set the location"
  type        = string

  validation {
    condition     = trimspace(var.location) != ""
    error_message = "location must not be empty."
  }
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
