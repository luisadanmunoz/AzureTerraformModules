#############################################################################
# LOAD BALANCER VARIABLES
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
variable "sku" {
  type = string
}
variable "name_ip" {
  type = string
}
variable "public_ip_address_id" {
  type = string
}
variable "tags" {
  default = {}
}
#############################################################################
# LOAD BALANCER - BACKEND
#############################################################################
variable "network_interface_id_01" {
  type = string
}
variable "network_interface_id_02" {
  type = string
}
variable "ip_configuration_name_01" {
  type = string
}
variable "ip_configuration_name_02" {
  type = string
}
#############################################################################
# LOAD BALANCER - RULE
#############################################################################
variable "backend_address_pool_ids" {
  type = list(string)
}

#############################################################################
# LOAD BALANCER - DIAGNOSTIC SETTINGS
#############################################################################
variable "name_diagnostic_setting" {
  type = string
}
variable "workspace_resource_id" {
  type = string
}

