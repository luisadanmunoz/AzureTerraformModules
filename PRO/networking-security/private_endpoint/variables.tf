#############################################################################
# PRIVATE ENDPOINT VARIABLES
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
variable "subnet_id" {
  type = string
}
variable "name_private_service_connection" {
  type = string
}
variable "custom_network_interface_name" {
  type = string
}
variable "subresource_names" {
  type = bool
}
variable "subresource" {
  type = string
}
variable "private_connection_resource_alias" {
  type = bool
}
variable "alias" {
  type = string
}
variable "private_connection_resource_id" {
  type = bool
}
variable "id" {
  type = string
}
