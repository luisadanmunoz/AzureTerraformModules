#############################################################################
# VM LINUX GRAFANA - VARIABLES
#############################################################################
variable "secret_name" {
  description = "value of the secret name tag"
  type        = string
}
variable "keyvault_id" {
  description = "value of the keyvault id tag"
  type        = string
}
variable "commom_tags" {
  description = "value of the commom tags tag"
  type        = map(any)
  default     = {}
}
variable "vm_name" {
  description = "value of the vm name tag"
  type        = string
}
variable "location" {
  description = "value of the location tag"
  type        = string
}
variable "resource_group_name" {
  description = "value of the resource group name tag"
  type        = string
}
variable "subnet_id" {
  description = "value of the subnet id tag"
  type        = string
}
variable "private_ip_address_allocation" {
  description = "value of the private ip address allocation tag"
  type        = string
}
variable "private_ip_address" {
  description = "value of the private ip address tag"
  type        = string
}
/*
variable "public_ip_address_id" {
  type = string
}
*/
variable "size" {
  description = "value of the size tag"
  type        = string
}
variable "admin_username" {
  description = "value of the admin username tag"
  type        = string
}
variable "computer_name" {
  description = "value of the computer name tag"
  type        = string
}


