#############################################################################
# VIRTUAL NETWORKS
#############################################################################
module "vnet" {
  source = "./modules/vnet"

  for_each = var.virtual_networks

  virtual_network_name = each.value["virtual_network_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location      = each.value["location"]
  address_space = each.value["address_space"]
  dns_servers   = try(each.value["dns_servers"], [])
  tags          = try(each.value["tags"], var.tags)
}
