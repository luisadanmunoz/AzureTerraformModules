#############################################################################
# LOCAL NETWORK GATEWAY
#############################################################################

module "local_network_gateway" {
  source = "./modules/local_network_gateway"

  for_each = var.local_network_gateway

  name                       = each.value["name"]
  resource_group_name        = each.value["resource_group_name"]
  location                   = each.value["location"]
  gateway_address            = each.value["gateway_address"]
  address_space              = each.value["address_space"]
  name_connect               = each.value["name_connect"]
  virtual_network_gateway_id = element([for k, v in module.vng : v.id if v.name == each.value["virtual_network_gateway"]], 0)
  type                       = each.value["type"]
  shared_key                 = each.value["shared_key"]

  dh_group         = each.value["dh_group"]
  ike_encryption   = each.value["ike_encryption"]
  ike_integrity    = each.value["ike_integrity"]
  ipsec_encryption = each.value["ipsec_encryption"]
  ipsec_integrity  = each.value["ipsec_integrity"]
  pfs_group        = each.value["pfs_group"]
  sa_datasize      = each.value["sa_datasize"]
  sa_lifetime      = each.value["sa_lifetime"]

  tags = var.tags
}