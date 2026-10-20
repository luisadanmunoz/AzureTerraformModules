# Variables azurerm_key_vault_secret

variable "secret_name" {
  type = string
}
variable "keyvault_id" {
  type = string
}
variable "tags" {
  type = map(string)
}

# Variables azurerm_network_interface

variable "vm_name" {
  type = string
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "subnet_id_ha" {
  type = string
}
variable "private_ip_address_allocation_ha" {
  type = string
}
variable "private_ip_address_ha" {
  type = string
}
variable "subnet_id_public" {
  type = string
}
variable "private_ip_address_allocation_public" {
  type = string
}
variable "private_ip_address_public_floating-public" {
  type = string
}
variable "private_ip_address_public" {
  type = string
}
variable "public_ip_address_id" {
  type = string
}
variable "subnet_id_mgmt" {
  type = string
}
variable "private_ip_address_allocation_mgmt" {
  type = string
}
variable "private_ip_address_mgmt" {
  type = string
}
variable "subnet_id_private" {
  type = string
}
variable "private_ip_address_allocation_private" {
  type = string
}
variable "private_ip_address_private" {
  type = string
}
variable "private_ip_address_private_floating-private" {
  type = string
}
variable "size" {
  type = string
}
variable "admin_username" {
  type = string
}
variable "publisher" {
  type = string
}
variable "offer" {
  type = string
}
variable "sku" {
  type = string
}
variable "os_version" {
  type = string
}
variable "os_disk" {
  type = string
}
variable "floating-public" {
  type = bool
}
variable "floating-private" {
  type = bool
}



