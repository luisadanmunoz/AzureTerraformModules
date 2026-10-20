#############################################################################
# IOT HUB FALLBACK ROUTES
#############################################################################
module "iothub_fallback_route" {
  source = "./modules/iothub_fallback_route"

  for_each = var.iothub_fallback_routes

  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  iothub_name = try(
    element([for _, iothub in module.iothub : iothub.name if iothub.name == each.value["iothub_name"]], 0),
    each.value["iothub_name"]
  )
  enabled               = each.value["enabled"]
  endpoint_names        = each.value["endpoint_names"]
  fallback_route_source = try(each.value["source"], null)
  condition             = try(each.value["condition"], null)
  timeouts              = try(each.value["timeouts"], null)
}
