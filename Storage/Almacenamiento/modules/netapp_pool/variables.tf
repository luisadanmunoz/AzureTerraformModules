#############################################################################
# VARIABLES NETAPP POOL
#############################################################################
variable "netapp_pool_name" {
  description = "value to set the netapp pool name"
  type        = string
}

variable "account_name" {
  description = "value to set the account name"
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

variable "service_level" {
  description = "value to set the service level"
  type        = string
}

variable "size_in_tb" {
  description = "value to set the size in tb"
  type        = number
}

variable "cool_access_enabled" {
  description = "value to set the cool access enabled"
  type        = bool
  default     = null
}

variable "custom_throughput_mibps" {
  description = "value to set the custom throughput mibps"
  type        = number
  default     = null
}

variable "encryption_type" {
  description = "value to set the encryption type"
  type        = string
  default     = null
}

variable "qos_type" {
  description = "value to set the qos type"
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
