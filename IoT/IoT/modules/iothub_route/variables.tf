#############################################################################
# VARIABLES IOT HUB ROUTE
#############################################################################
variable "iothub_route_name" {
  description = "value to set the iot hub route name"
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

variable "route_source" {
  description = "value to set the route source"
  type        = string
}

variable "endpoint_names" {
  description = "value to set the endpoint names"
  type        = list(string)
}

variable "enabled" {
  description = "value to set the enabled flag"
  type        = bool
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
