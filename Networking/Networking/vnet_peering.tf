#############################################################################
# VNET PEERINGS
#############################################################################
module "vnet_peering" {
  source = "./modules/vnet_peering"

  for_each = var.virtual_network_peerings

  peering_name = each.value["peering_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  virtual_network_name = try(
    element([for _, virtual_network in module.vnet : virtual_network.name if virtual_network.name == each.value["virtual_network_name"]], 0),
    each.value["virtual_network_name"]
  )
  remote_virtual_network_id = try(
    element([for _, virtual_network in module.vnet : virtual_network.id if virtual_network.name == each.value["remote_virtual_network_name"]], 0),
    each.value["remote_virtual_network_id"]
  )
  allow_virtual_network_access = try(each.value["allow_virtual_network_access"], true)
  allow_forwarded_traffic      = try(each.value["allow_forwarded_traffic"], false)
  allow_gateway_transit        = try(each.value["allow_gateway_transit"], false)
  use_remote_gateways          = try(each.value["use_remote_gateways"], false)
}
