#############################################################################
# VARIABLES PRIVATE DNS ZONE VIRTUAL NETWORK LINK
#############################################################################
variable "private_dns_zone_virtual_network_link_name" {
  description = "value to set the private dns zone virtual network link name"
  type        = string

  validation {
    condition     = trimspace(var.private_dns_zone_virtual_network_link_name) != ""
    error_message = "private_dns_zone_virtual_network_link_name must not be empty."
  }
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "private_dns_zone_name" {
  description = "value to set the private dns zone name"
  type        = string

  validation {
    condition     = trimspace(var.private_dns_zone_name) != ""
    error_message = "private_dns_zone_name must not be empty."
  }
}

variable "virtual_network_id" {
  description = "value to set the virtual network id"
  type        = string

  validation {
    condition     = trimspace(var.virtual_network_id) != "" && startswith(var.virtual_network_id, "/subscriptions/")
    error_message = "virtual_network_id must be a valid Azure resource id."
  }
}

variable "registration_enabled" {
  description = "value to enable auto registration for private dns records"
  type        = bool
  default     = false
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
