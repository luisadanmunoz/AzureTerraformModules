variable "secret_name" {
  type = string
}
variable "keyvault_id" {
  type = string
}
variable "commom_tags" {
  default = {}
}
variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "administrator_login" {
  type = string
}
/*
variable "administrator_password" {
  type = string
}
*/
variable "backup_retention_days" {
  type = string
}
/*
variable "delegated_subnet_id" {
  type = string
}

variable "private_dns_zone_id" {
  type = string
}
*/
variable "sku_name" {
  type = string
}
variable "zone" {
  type = string
}

variable "subnet_id" {
  type = string
}
variable "private_ip_address" {
  type = string
}
variable "subresource_name" {
  type = string
}
variable "member_name" {
  type = string
}

/*
variable "public_network_access_enabled" {
  default = {}
  
}

*/

