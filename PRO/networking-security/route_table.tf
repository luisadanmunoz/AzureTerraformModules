#############################################################################
# ROUTE TABLE
#############################################################################
module "route_table" {
  source = "./moduleS/route_table"

  for_each = var.route_table

  name                = each.value["name"]
  resource_group_name = each.value["resource_group_name"]
  location            = each.value["location"]
  #############################################################################
  # DYNAMIC BLOCKS ROUTE
  #############################################################################
  enable_route = each.value.enable_route
  routes       = each.value.routes

}