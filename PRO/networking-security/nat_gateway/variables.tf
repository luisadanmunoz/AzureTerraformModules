#############################################################################
# NAT GATEWAY VARIABLES
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
variable "tags" {
  default = {}
}
#############################################################################
# NAT GATEWAY PUBLIC IP ASSOCIATION
#############################################################################
/*
variable "public_ip_address_id" {
  type = string
}

#############################################################################
# NAT GATEWAY SUBNET ASSOCIATION - 1
#############################################################################
variable "subnet_id_1" {
  type = string
}
*/
#############################################################################
# NAT GATEWAY SUBNET ASSOCIATION - 2
#############################################################################
variable "subnet_id_2" {
  type = string
}