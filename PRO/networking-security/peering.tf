#############################################################################
# PEERING VIRTUAL NETWORKS
#############################################################################
module "peering" {
  source = "./modules/peering"

  providers = {
    azurerm     = azurerm
    azurerm.hub = azurerm.hub
  }

  for_each = var.peering

  peering_name_vnet_01            = each.value["peering_name_vnet_01"]
  resource_group_vnet_01          = each.value["resource_group_vnet_01"]
  name_vnet_01                    = each.value["name_vnet_01"]
  use_remote_gateways_01          = each.value["use_remote_gateways_01"]
  allow_virtual_network_access_01 = each.value["allow_virtual_network_access_01"]
  allow_forwarded_traffic_01      = each.value["allow_forwarded_traffic_01"]
  allow_gateway_transit_01        = each.value["allow_gateway_transit_01"]
  peering_name_vnet_02            = each.value["peering_name_vnet_02"]
  resource_group_vnet_02          = each.value["resource_group_vnet_02"]
  name_vnet_02                    = each.value["name_vnet_02"]
  vnet_id_01                      = element([for k, v in module.vnet : v.id if v.name == each.value["name_vnet_01"]], 0) //element([for k, v in module.vnet : v.id if k == each.value["location"]], 0)
  use_remote_gateways_02          = each.value["use_remote_gateways_02"]
  allow_virtual_network_access_02 = each.value["allow_virtual_network_access_02"]
  allow_forwarded_traffic_02      = each.value["allow_forwarded_traffic_02"]
  allow_gateway_transit_02        = each.value["allow_gateway_transit_02"]

}