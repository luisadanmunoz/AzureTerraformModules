#############################################################################
# VARIABLES IOT HUB SHARED ACCESS POLICY
#############################################################################
variable "iothub_shared_access_policy_name" {
  description = "value to set the iot hub shared access policy name"
  type        = string
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "iothub_name" {
  description = "value to set the iot hub name"
  type        = string
}

variable "registry_read" {
  description = "value to set the registry read permission"
  type        = bool
  default     = null
}

variable "registry_write" {
  description = "value to set the registry write permission"
  type        = bool
  default     = null
}

variable "service_connect" {
  description = "value to set the service connect permission"
  type        = bool
  default     = null
}

variable "device_connect" {
  description = "value to set the device connect permission"
  type        = bool
  default     = null
}

variable "timeouts" {
  description = "value to set the timeouts"
  type = object({
    create = optional(string)
    read   = optional(string)
    delete = optional(string)
  })
  default = null
}
