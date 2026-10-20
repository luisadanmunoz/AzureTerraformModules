# #############################################################################
# PRIVATE DNS ZONE VARIABLES
# #############################################################################
variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "tags" {
  default = {}
}
# #############################################################################
# PRIVATE DNS ZONE VNET LINK VARIABLES
# #############################################################################
variable "virtual_network_id" {
  type = string
}