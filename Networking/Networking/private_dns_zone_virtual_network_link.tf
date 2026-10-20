#############################################################################
# PRIVATE DNS ZONE VIRTUAL NETWORK LINKS
#############################################################################
module "private_dns_zone_virtual_network_link" {
  source = "./modules/private_dns_zone_virtual_network_link"

  for_each = var.private_dns_zone_virtual_network_links

  private_dns_zone_virtual_network_link_name = each.value["private_dns_zone_virtual_network_link_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  private_dns_zone_name = try(
    element([for _, private_dns_zone in module.private_dns_zone : private_dns_zone.name if private_dns_zone.name == each.value["private_dns_zone_name"]], 0),
    each.value["private_dns_zone_name"]
  )
  virtual_network_id = try(
    element([for _, virtual_network in module.vnet : virtual_network.id if virtual_network.name == each.value["virtual_network_name"]], 0),
    each.value["virtual_network_id"]
  )
  registration_enabled = try(each.value["registration_enabled"], false)
  tags                 = try(each.value["tags"], var.tags)
}
