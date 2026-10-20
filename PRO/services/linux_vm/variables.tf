#############################################################################
# RANDOM PASSWORD
#############################################################################
variable "keyvault_id" {
  type = string
}
variable "tags" {
  type    = map(any)
  default = {}
}
#############################################################################
# LINUX VIRTUAL MACHINE MODULE - NETWORK INTERFACE
#############################################################################
variable "vm_name" {
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
variable "private_ip_address_allocation" {
  type = string
}
variable "private_ip_address" {
  type = string
}
/*
variable "private_ip_address" {
  default = {}
}
*/
#############################################################################
# LINUX VIRTUAL MACHINE MODULE
#############################################################################
variable "size" {
  default = {}
}
variable "admin_username" {
  default = {}
}
variable "publisher" {
  default = {}
}
variable "offer" {
  default = {}
}
variable "sku" {
  default = {}
}
variable "os_version" {
  default = {}
}