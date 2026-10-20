#############################################################################
# KEY VAULT VARIABLES
#############################################################################
variable "name" {
  default = {}
}
variable "location" {
  default = {}
}
variable "resource_group_name" {
  default = {}
}
#############################################################################
# KEY VAULT - PRIVATE ENDPOINT
#############################################################################
variable "subnet_id" {
  default = {}
}
variable "object_id_01" {
  default = {}
}
variable "tenant_id" {
  default = {}
}
variable "sku_name" {
  default = {}
}
variable "tags" {
  default = {}
}
variable "private_dns_zone_ids" {
  default = {}
}