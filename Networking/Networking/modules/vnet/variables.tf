#############################################################################
# VARIABLES VIRTUAL NETWORK
#############################################################################
variable "virtual_network_name" {
  description = "value to set the virtual network name"
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

variable "address_space" {
  description = "value to set the address space"
  type        = list(string)
}

variable "dns_servers" {
  description = "value to set the dns servers"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
