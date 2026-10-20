# #############################################################################
# # ALIAS - PEERING GLOBAL
# #############################################################################
terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      configuration_aliases = [azurerm.hub]
    }
  }
}
# #############################################################################
# # VIRTUAL NETWORK SUBSCRIPTION HUB - REMOTA
# #############################################################################
data "azurerm_virtual_network" "vnet_hub" {
  name                = var.name_vnet_02
  resource_group_name = var.resource_group_vnet_02
  provider            = azurerm.hub
}
# #############################################################################
# # PEERING FROM - SPOKE TO HUB
# #############################################################################
resource "azurerm_virtual_network_peering" "peering_01" {
  name                         = var.peering_name_vnet_01
  resource_group_name          = var.resource_group_vnet_01
  virtual_network_name         = var.name_vnet_01
  remote_virtual_network_id    = data.azurerm_virtual_network.vnet_hub.id
  use_remote_gateways          = var.use_remote_gateways_01
  allow_virtual_network_access = var.allow_virtual_network_access_01
  allow_forwarded_traffic      = var.allow_forwarded_traffic_01
  allow_gateway_transit        = var.allow_gateway_transit_01
}
# #############################################################################
# # PEERING - HUB TO SPOKE
# #############################################################################
resource "azurerm_virtual_network_peering" "peering_02" {
  name                         = var.peering_name_vnet_02
  resource_group_name          = var.resource_group_vnet_02
  virtual_network_name         = var.name_vnet_02
  remote_virtual_network_id    = var.vnet_id_01
  use_remote_gateways          = var.use_remote_gateways_02
  allow_virtual_network_access = var.allow_virtual_network_access_02
  allow_forwarded_traffic      = var.allow_forwarded_traffic_02
  allow_gateway_transit        = var.allow_gateway_transit_02
  provider                     = azurerm.hub

  depends_on = [azurerm_virtual_network_peering.peering_01]
}