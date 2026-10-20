#############################################################################
# AKS
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
variable "node_resource_group" {
  type = string
}
variable "dns_prefix_private_cluster" {
  type = string
}
variable "private_dns_zone_id" {
  type = string
}
variable "identity_ids" {
  type = set(string)
}
variable "vnet_subnet_id" {
  type = string
}
variable "gateway_id" {
  type = string
}
variable "tags" {
  type    = map(any)
  default = {}
}
#############################################################################
# ROLE ASSIGMENT - DNS y RG
#############################################################################
variable "scope_dns" {
  type = string
}
variable "principal_id_identity" {
  type = string
}
variable "scope_rg" {
  type = string
}