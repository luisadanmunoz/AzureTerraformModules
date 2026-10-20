#############################################################################
# AZURE BASTION
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
variable "nameip" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "public_ip_address_id" {
  type = string
}
variable "tags" {
  default = {}
}
variable "sku" {
  type = string
}
variable "tunneling_enabled" {
  type = bool
}
#############################################################################
# DIAGNOSTIC SETTINGS
#############################################################################
variable "name_diagnostic_setting" {
  type = string
}
variable "workspace_resource_id" {
  type = string
}