#############################################################################
# VARIABLES NAT GATEWAY
#############################################################################
variable "nat_gateway_name" {
  description = "value to set the nat gateway name"
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

variable "sku_name" {
  description = "value to set the sku name"
  type        = string
  default     = "Standard"
}

variable "idle_timeout_in_minutes" {
  description = "value to set the idle timeout"
  type        = number
  default     = 4
}

variable "public_ip_id_map" {
  description = "value to set the public ip ids map"
  type        = map(string)
  default     = {}
}

variable "public_ip_prefix_id_map" {
  description = "value to set the public ip prefix ids map"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
