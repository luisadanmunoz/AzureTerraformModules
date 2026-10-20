#############################################################################
# AZURE FIREWALL VARIABLES
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
variable "public_ip_address_id" {
  type = string
}
variable "tags" {
  type    = map(any)
  default = {}
}
variable "management_name" {
  type = string
}
variable "subnet_management_id" {
  type = string
}
variable "management_public_ip_address_id" {
  type = string
}
#############################################################################
# AZURE FIREWALL POLICY VARIABLES
#############################################################################
variable "name_firewall_policy" {
  type = string
}