# #############################################################################
# PALO ALTO KEYVAULT
# #############################################################################
variable "keyvault_name" {
  type = string
}
variable "keyvault_resourcegroup_name" {
  type = string
}
variable "keyvault_secret_name_01" {
  type = string
}
# #############################################################################
# PALO ALTO NETWORKING
# #############################################################################
variable "vnet_name_01" {
  type = string
}
variable "vnet_resourcegroup_01" {
  type = string
}
# #############################################################################
# PALO ALTO NIC MANAGEMENT
# #############################################################################
variable "subnet_name_01" {
  type = string
}
variable "vm_location_01" {
  type = string
}
variable "vm_resourcegroup_01" {
  type = string
}
variable "interface_config_name_01" {
  type = string
}
variable "interface_privateip_allocation_01" {
  type = string
}
variable "interface_privateip_address_01" {
  type = string
}
variable "interface_name_01" {
  type = string
}
# #############################################################################
# PALO ALTO NIC TRUST
# #############################################################################
variable "subnet_name_02" {
  type = string
}
variable "interface_name_02" {
  type = string
}
variable "interface_config_name_02" {
  type = string
}
variable "interface_privateip_allocation_02" {
  type = string
}
/*
variable "interface_privateip_address_02" {
type = string
}
*/
# #############################################################################
# PALO ALTO NIC UNTRUST
# #############################################################################
variable "subnet_name_03" {
  type = string
}
variable "interface_name_03" {
  type = string
}
variable "interface_config_name_03" {
  type = string
}
variable "interface_privateip_allocation_03" {
  type = string
}
/*
variable "interface_privateip_address_03" {
type = string
}
*/
# #############################################################################
# PALO ALTO VIRTUAL MACHINE
# #############################################################################
variable "vm_name_01" {
  type = string
}
variable "vm_size_01" {
  type = string
}
variable "vm_osdisk_name_01" {
  type = string
}
variable "vm_image_publisher_01" {
  type = string
}
variable "vm_image_offer_01" {
  type = string
}
variable "vm_image_sku_01" {
  type = string
}
variable "vm_image_version_01" {
  type = string
}
variable "zones" {
  type = string
}
variable "tags" {
  type    = map(any)
  default = {}
}