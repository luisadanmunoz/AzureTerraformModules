#############################################################################
# IOT HUB ROUTES
#############################################################################
module "iothub_route" {
  source = "./modules/iothub_route"

  for_each = var.iothub_routes

  iothub_route_name = each.value["iothub_route_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  iothub_name = try(
    element([for _, iothub in module.iothub : iothub.name if iothub.name == each.value["iothub_name"]], 0),
    each.value["iothub_name"]
  )
  route_source   = each.value["source"]
  endpoint_names = each.value["endpoint_names"]
  enabled        = each.value["enabled"]
  condition      = try(each.value["condition"], null)
  timeouts       = try(each.value["timeouts"], null)
}
