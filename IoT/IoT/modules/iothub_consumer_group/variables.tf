#############################################################################
# VARIABLES IOT HUB CONSUMER GROUP
#############################################################################
variable "iothub_consumer_group_name" {
  description = "value to set the iot hub consumer group name"
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

variable "eventhub_endpoint_name" {
  description = "value to set the eventhub endpoint name"
  type        = string
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
