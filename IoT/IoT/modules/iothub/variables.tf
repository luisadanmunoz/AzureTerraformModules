#############################################################################
# VARIABLES IOT HUB
#############################################################################
variable "iothub_name" {
  description = "value to set the iot hub name"
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

variable "event_hub_partition_count" {
  description = "value to set the event hub partition count"
  type        = number
  default     = null
}

variable "event_hub_retention_in_days" {
  description = "value to set the event hub retention in days"
  type        = number
  default     = null
}

variable "local_authentication_enabled" {
  description = "value to set the local authentication enabled flag"
  type        = bool
  default     = null
}

variable "min_tls_version" {
  description = "value to set the minimum tls version"
  type        = string
  default     = null
}

variable "public_network_access_enabled" {
  description = "value to set the public network access enabled flag"
  type        = bool
  default     = null
}

variable "cloud_to_device" {
  description = "value to set the cloud to device configuration"
  type = object({
    default_ttl        = optional(string)
    max_delivery_count = optional(number)
    feedback = optional(object({
      lock_duration      = optional(string)
      max_delivery_count = optional(number)
      time_to_live       = optional(string)
    }))
  })
  default = null
}

variable "identity" {
  description = "value to set the identity"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "network_rule_set" {
  description = "value to set the network rule set"
  type = object({
    apply_to_builtin_eventhub_endpoint = optional(bool)
    default_action                     = optional(string)
    ip_rule = optional(list(object({
      name    = string
      ip_mask = string
      action  = optional(string)
    })))
  })
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
