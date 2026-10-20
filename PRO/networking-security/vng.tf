#############################################################################
# RESOURCES VIRTUAL NETWORK GATEWAY
#############################################################################
module "vng" {
  source = "./modules/vng"

  for_each = var.vng

  name                 = each.value["name"]
  location             = each.value["location"]
  resource_group_name  = each.value["resource_group_name"]
  type                 = each.value["type"]
  vpn_type             = each.value["vpn_type"]
  active_active        = each.value["active_active"]
  enable_bgp           = each.value["enable_bgp"]
  sku                  = each.value["sku"]
  public_ip_address_id = element([for k, v in module.public_ip : v.id if v.name == each.value["pip"]], 0)
  subnet_id            = element([for k, v in module.subnet : v.id if v.name == each.value["subnet"]], 0)


  //express_route_circuit_id      = element([for k, v in module.express_route : v.id if k == each.value["location"]], 0)

  //name_connection               = each.value["name_connection"]
  //shared_key                    = each.value ["shared_key"]
  #############################################################################
  # DIAGNOSTIC SETTING
  #############################################################################
  name_diagnostic_setting = each.value["name_diagnostic_setting"]
  workspace_resource_id   = element([for k, v in module.log_analytics : v.id if v.name == each.value["log_analytics"]], 0)

  tags = var.tags
}
