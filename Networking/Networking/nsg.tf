#############################################################################
# NETWORK SECURITY GROUPS
#############################################################################
module "nsg" {
  source = "./modules/nsg"

  for_each = var.network_security_groups

  nsg_name = each.value["nsg_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location       = each.value["location"]
  security_rules = coalesce(try(each.value["security_rules"], null), [])
  tags           = try(each.value["tags"], var.tags)
}
