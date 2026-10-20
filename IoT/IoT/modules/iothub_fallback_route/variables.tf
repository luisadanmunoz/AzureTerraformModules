#############################################################################
# VARIABLES IOT HUB FALLBACK ROUTE
#############################################################################
variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "iothub_name" {
  description = "value to set the iot hub name"
  type        = string
}

variable "enabled" {
  description = "value to set the enabled flag"
  type        = bool
}

variable "endpoint_names" {
  description = "value to set the endpoint names"
  type        = list(string)
}

variable "fallback_route_source" {
  description = "value to set the fallback route source"
  type        = string
  default     = null
}

variable "condition" {
  description = "value to set the condition"
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
