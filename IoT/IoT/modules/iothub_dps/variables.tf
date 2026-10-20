#############################################################################
# VARIABLES IOT HUB DPS
#############################################################################
variable "iothub_dps_name" {
  description = "value to set the iot hub dps name"
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

variable "allocation_policy" {
  description = "value to set the allocation policy"
  type        = string
  default     = null
}

variable "data_residency_enabled" {
  description = "value to set the data residency enabled flag"
  type        = bool
  default     = null
}

variable "public_network_access_enabled" {
  description = "value to set the public network access enabled flag"
  type        = bool
  default     = null
}

variable "ip_filter_rule" {
  description = "value to set the ip filter rules"
  type = list(object({
    name    = string
    ip_mask = string
    action  = string
    target  = optional(string)
  }))
  default = null
}

variable "linked_hub" {
  description = "value to set the linked hubs"
  type = list(object({
    connection_string       = string
    location                = string
    allocation_weight       = optional(number)
    apply_allocation_policy = optional(bool)
  }))
  default = null
}

variable "sku" {
  description = "value to set the sku"
  type = object({
    name     = string
    capacity = number
  })
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
