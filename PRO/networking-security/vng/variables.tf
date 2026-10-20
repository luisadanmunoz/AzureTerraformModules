#############################################################################
# VIRTUAL NETWORK GATEWAY VARIABLES
#############################################################################
variable "name" {
  type = string
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "vpn_type" {
  type = string
}
variable "active_active" {
  type = string
}
variable "enable_bgp" {
  type = string
}
variable "sku" {
  type = string
}
variable "public_ip_address_id" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "tags" {
  default = {}
}
variable "type" {
  type = string
}
/*
variable "name_connection" {
  type = string
}

variable "shared_key" {
  type = string
}

variable "express_route_circuit_id" {
type = string
}
*/
#############################################################################
# DIAGNOSTIC SETTINGS
#############################################################################
variable "name_diagnostic_setting" {
  type = string
}
variable "workspace_resource_id" {
  type = string
}