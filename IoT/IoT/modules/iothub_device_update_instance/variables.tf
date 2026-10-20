#############################################################################
# VARIABLES IOT HUB DEVICE UPDATE INSTANCE
#############################################################################
variable "iothub_device_update_instance_name" {
  description = "value to set the iot hub device update instance name"
  type        = string
}

variable "device_update_account_id" {
  description = "value to set the device update account id"
  type        = string
}

variable "iothub_id" {
  description = "value to set the iot hub id"
  type        = string
}

variable "diagnostic_enabled" {
  description = "value to set the diagnostic enabled flag"
  type        = bool
  default     = null
}

variable "diagnostic_storage_account" {
  description = "value to set the diagnostic storage account"
  type = object({
    connection_string = string
    id                = string
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
