# #############################################################################
# # PEERING FROM - SPOKE TO HUB
# #############################################################################
variable "peering_name_vnet_01" {
  type = string
}

variable "resource_group_vnet_01" {
  type = string
}

variable "name_vnet_01" {
  type = string
}

variable "vnet_id_01" {
  type = string
}

variable "use_remote_gateways_01" {
  type = bool
}

variable "allow_virtual_network_access_01" {
  type = bool
}

variable "allow_forwarded_traffic_01" {
  type = bool
}

variable "allow_gateway_transit_01" {
  type = bool
}
# #############################################################################
# # PEERING - HUB TO SPOKE
# #############################################################################
variable "peering_name_vnet_02" {
  type = string
}

variable "resource_group_vnet_02" {
  type = string
}
# #############################################################################
# # VIRTUAL NETWORK SUBSCRIPTION HUB - REMOTA
# #############################################################################
variable "name_vnet_02" {
  type = string
}

variable "use_remote_gateways_02" {
  type = bool
}

variable "allow_virtual_network_access_02" {
  type = bool
}

variable "allow_forwarded_traffic_02" {
  type = bool
}

variable "allow_gateway_transit_02" {
  type = bool
}