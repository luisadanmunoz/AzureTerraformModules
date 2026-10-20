variable "secret_name" {
  type = string
}
variable "keyvault_id" {
  type = string
}
variable "commom_tags" {
  type    = map(any)
  default = {}
}
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
variable "public_ip_address_id" {
  type = string
}
*/
variable "size" {
  type = string
}
variable "admin_username" {
  type = string
}

variable "dcr_assoc_id" {
  type = string
}
variable "dcr_vminsight_assoc_id" {
  type = string
}

variable "computer_name" {
  type = string
}
