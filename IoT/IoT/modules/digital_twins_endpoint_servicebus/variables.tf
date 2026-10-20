#############################################################################
# VARIABLES DIGITAL TWINS ENDPOINT SERVICEBUS
#############################################################################
variable "digital_twins_endpoint_servicebus_name" {
  description = "value to set the digital twins endpoint servicebus name"
  type        = string
}

variable "digital_twins_id" {
  description = "value to set the digital twins id"
  type        = string
}

variable "servicebus_primary_connection_string" {
  description = "value to set the servicebus primary connection string"
  type        = string
}

variable "servicebus_secondary_connection_string" {
  description = "value to set the servicebus secondary connection string"
  type        = string
}

variable "dead_letter_storage_secret" {
  description = "value to set the dead letter storage secret"
  type        = string
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
