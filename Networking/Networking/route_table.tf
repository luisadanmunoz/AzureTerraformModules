#############################################################################
# ROUTE TABLES
#############################################################################
module "route_table" {
  source = "./modules/route_table"

  for_each = var.route_tables

  route_table_name = each.value["route_table_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                      = each.value["location"]
  bgp_route_propagation_enabled = try(each.value["bgp_route_propagation_enabled"], true)
  routes                        = coalesce(try(each.value["routes"], null), [])
  tags                          = try(each.value["tags"], var.tags)
}
