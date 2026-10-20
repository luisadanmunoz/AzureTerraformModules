#############################################################################
# EXPRESS ROUTE CIRCUIT VARIABLES
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
variable "service_provider_name" {
  type = string
}
variable "peering_location" {
  type = string
}
variable "bandwidth_in_mbps" {
  default = {}
}
variable "tier" {
  type = string
}
variable "family" {
  type = string
}
variable "tags" {
  default = {}
}
#############################################################################
# EXPRESS ROUTE CIRCUIT PEERING
#############################################################################
variable "peering_type" {
  type = string
}
variable "express_route_circuit_name" {
  type = string
}
variable "peer_asn" {
  default = {}
}
variable "primary_peer_address_prefix" {
  type = string
}
variable "secondary_peer_address_prefix" {
  type = string
}
variable "vlan_id" {
  default = {}
}
#############################################################################
# VIRTUAL NETWORK GATEWAY CONNECTION - TYPE EXPRESS ROUTE
#############################################################################
variable "name_connection" {
  type = string
}
variable "virtual_network_gateway_id" {
  type = string
}
variable "type" {
  type = string
}
variable "shared_key" {
  type = string
}
#############################################################################
# DIAGNOSTIC SETTINGS
#############################################################################
variable "name_diagnostic_setting" {
  type = string
}
variable "workspace_resource_id" {
  type = string
}