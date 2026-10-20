#############################################################################
# PRIVATE DNS ZONES
#############################################################################
module "private_dns_zone" {
  source = "./modules/private_dns_zone"

  for_each = var.private_dns_zones

  private_dns_zone_name = each.value["private_dns_zone_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  tags = try(each.value["tags"], var.tags)
}
