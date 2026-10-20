#############################################################################
# LOCAL NETWORK GATEWAY VARIABLES
#############################################################################
variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "gateway_address" {
  type = string
}
variable "address_space" {
  type = list(string)
}
#############################################################################
# VIRTUAL NETWORK GATEWAY CONNECTION
#############################################################################
variable "name_connect" {
  type = string
}
variable "type" {
  type = string
}
variable "virtual_network_gateway_id" {
  type = string
}
variable "shared_key" {
  type = string
}
variable "dh_group" {
  type = string
}
variable "ike_encryption" {
  type = string
}
variable "ike_integrity" {
  type = string
}
variable "ipsec_encryption" {
  type = string
}
variable "ipsec_integrity" {
  type = string
}
variable "pfs_group" {
  type = string
}
variable "sa_datasize" {
  type = string
}
variable "sa_lifetime" {
  type = string
}
variable "tags" {
  type    = map(any)
  default = {}
}