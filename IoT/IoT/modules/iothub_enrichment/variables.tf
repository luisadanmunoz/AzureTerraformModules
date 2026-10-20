#############################################################################
# VARIABLES IOT HUB ENRICHMENT
#############################################################################
variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "iothub_name" {
  description = "value to set the iot hub name"
  type        = string
}

variable "key" {
  description = "value to set the key"
  type        = string
}

variable "value" {
  description = "value to set the value"
  type        = string
}

variable "endpoint_names" {
  description = "value to set the endpoint names"
  type        = list(string)
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
