#############################################################################
# RESOURCES EXPRESS ROUTE
#############################################################################
module "express_route" {
  source = "./modules/express_route"

  for_each = var.express_route

  name                  = each.value["name"]
  resource_group_name   = each.value["resource_group_name"]
  location              = each.value["location"]
  service_provider_name = each.value["service_provider_name"]
  peering_location      = each.value["peering_location"]
  bandwidth_in_mbps     = each.value["bandwidth_in_mbps"]
  tier                  = each.value["tier"]
  family                = each.value["family"]
  tags                  = var.tags
  #############################################################################
  # EXPRESS ROUTE CIRCUIT PEERING
  #############################################################################
  peering_type                  = each.value["peering_type"]
  express_route_circuit_name    = each.value["express_route_circuit_name"]
  shared_key                    = each.value["shared_key"]
  peer_asn                      = each.value["peer_asn"]
  primary_peer_address_prefix   = each.value["primary_peer_address_prefix"]
  secondary_peer_address_prefix = each.value["secondary_peer_address_prefix"]
  vlan_id                       = each.value["vlan_id"]
  #############################################################################
  # VIRTUAL NETWORK GATEWAY CONNECTION - TYPE EXPRESS ROUTE
  #############################################################################
  name_connection            = each.value["name_connection"]
  virtual_network_gateway_id = element([for k, v in module.vng : v.id if v.name == each.value["virtual_network_gateway"]], 0)
  type                       = each.value["type"]
  #############################################################################
  # DIAGNOSTIC SETTINGS
  #############################################################################
  name_diagnostic_setting = each.value["name_diagnostic_setting"]
  workspace_resource_id   = element([for k, v in module.log_analytics : v.id if v.name == each.value["workspace"]], 0)

  depends_on = [module.vng]
}