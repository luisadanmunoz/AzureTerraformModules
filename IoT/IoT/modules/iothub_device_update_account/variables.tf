#############################################################################
# VARIABLES IOT HUB DEVICE UPDATE ACCOUNT
#############################################################################
variable "iothub_device_update_account_name" {
  description = "value to set the iot hub device update account name"
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

variable "public_network_access_enabled" {
  description = "value to set the public network access enabled flag"
  type        = bool
  default     = null
}

variable "sku" {
  description = "value to set the sku"
  type        = string
  default     = null
}

variable "identity" {
  description = "value to set the identity"
  type = object({
    type         = string
    identity_ids = optional(list(string))
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
