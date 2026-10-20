#############################################################################
# VARIABLES IOT HUB DPS CERTIFICATE
#############################################################################
variable "iothub_dps_certificate_name" {
  description = "value to set the iot hub dps certificate name"
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

variable "certificate_content" {
  description = "value to set the certificate content"
  type        = string
}

variable "is_verified" {
  description = "value to set the verified flag"
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
