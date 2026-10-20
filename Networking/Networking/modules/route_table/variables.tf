#############################################################################
# VARIABLES ROUTE TABLE
#############################################################################
variable "route_table_name" {
  description = "value to set the route table name"
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

variable "bgp_route_propagation_enabled" {
  description = "value to set the bgp route propagation enabled"
  type        = bool
  default     = true
}

variable "routes" {
  description = "value to set the routes"
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = []
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
