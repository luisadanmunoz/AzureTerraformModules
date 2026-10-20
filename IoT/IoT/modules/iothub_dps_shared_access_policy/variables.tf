#############################################################################
# VARIABLES IOT HUB DPS SHARED ACCESS POLICY
#############################################################################
variable "iothub_dps_shared_access_policy_name" {
  description = "value to set the iot hub dps shared access policy name"
  type        = string
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "iothub_dps_name" {
  description = "value to set the iot hub dps name"
  type        = string
}

variable "enrollment_read" {
  description = "value to set the enrollment read permission"
  type        = bool
  default     = null
}

variable "enrollment_write" {
  description = "value to set the enrollment write permission"
  type        = bool
  default     = null
}

variable "registration_read" {
  description = "value to set the registration read permission"
  type        = bool
  default     = null
}

variable "registration_write" {
  description = "value to set the registration write permission"
  type        = bool
  default     = null
}

variable "service_config" {
  description = "value to set the service config permission"
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
