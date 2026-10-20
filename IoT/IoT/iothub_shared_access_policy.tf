#############################################################################
# IOT HUB SHARED ACCESS POLICIES
#############################################################################
module "iothub_shared_access_policy" {
  source = "./modules/iothub_shared_access_policy"

  for_each = var.iothub_shared_access_policies

  iothub_shared_access_policy_name = each.value["iothub_shared_access_policy_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  iothub_name = try(
    element([for _, iothub in module.iothub : iothub.name if iothub.name == each.value["iothub_name"]], 0),
    each.value["iothub_name"]
  )
  registry_read   = try(each.value["registry_read"], null)
  registry_write  = try(each.value["registry_write"], null)
  service_connect = try(each.value["service_connect"], null)
  device_connect  = try(each.value["device_connect"], null)
  timeouts        = try(each.value["timeouts"], null)
}
