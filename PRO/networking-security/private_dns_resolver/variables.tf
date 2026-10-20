#############################################################################
# PRIVATE DNS RESOLVER
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
variable "virtual_network_id" {
  type = string
}
variable "tags" {
  default = {}
}
#############################################################################
# PRIVATE DNS RESOLVER - OUTBOUND ENDPOINT
#############################################################################
variable "name_outbound" {
  type = string
}
variable "subnet_id_outbound" {
  default = {}
}
#############################################################################
# PRIVATE DNS RESOLVER - INBOUND ENDPOINT
#############################################################################
variable "name_inbound" {
  default = {}
}
variable "private_ip" {
  default = {}
}
variable "subnet_id_inbound" {
  default = {}
}
#############################################################################
# PRIVATE DNS RESOLVER - FORWARDING RULESET
#############################################################################
variable "name_forwarding_ruleset" {
  type = string
}
#############################################################################
# PRIVATE DNS RESOLVER - NETWORK LINK
#############################################################################
variable "name_virtual_network_link" {
  type = string
}