#############################################################################
# VARIABLES VNET PEERING
#############################################################################
variable "peering_name" {
  description = "value to set the peering name"
  type        = string
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "virtual_network_name" {
  description = "value to set the virtual network name"
  type        = string
}

variable "remote_virtual_network_id" {
  description = "value to set the remote virtual network id"
  type        = string
}

variable "allow_virtual_network_access" {
  description = "value to allow virtual network access"
  type        = bool
  default     = true
}

variable "allow_forwarded_traffic" {
  description = "value to allow forwarded traffic"
  type        = bool
  default     = false
}

variable "allow_gateway_transit" {
  description = "value to allow gateway transit"
  type        = bool
  default     = false
}

variable "use_remote_gateways" {
  description = "value to use remote gateways"
  type        = bool
  default     = false
}
