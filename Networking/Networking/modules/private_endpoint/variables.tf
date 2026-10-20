#############################################################################
# VARIABLES PRIVATE ENDPOINT
#############################################################################
variable "private_endpoint_name" {
  description = "value to set the private endpoint name"
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

variable "subnet_id" {
  description = "value to set the subnet id"
  type        = string
}

variable "custom_network_interface_name" {
  description = "value to set the custom network interface name"
  type        = string
  default     = null
}

variable "private_service_connection_name" {
  description = "value to set the private service connection name"
  type        = string
  default     = null
}

variable "private_connection_resource_id" {
  description = "value to set the private connection resource id"
  type        = string
}

variable "subresource_names" {
  description = "value to set the subresource names"
  type        = list(string)
}

variable "is_manual_connection" {
  description = "value to set the manual connection flag"
  type        = bool
  default     = false
}

variable "request_message" {
  description = "value to set the request message"
  type        = string
  default     = null
}

variable "private_dns_zone_group_name" {
  description = "value to set the private dns zone group name"
  type        = string
  default     = "default"
}

variable "private_dns_zone_ids" {
  description = "value to set the private dns zone ids"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
