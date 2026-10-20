#############################################################################
# IOT HUB DPS SHARED ACCESS POLICIES
#############################################################################
module "iothub_dps_shared_access_policy" {
  source = "./modules/iothub_dps_shared_access_policy"

  for_each = var.iothub_dps_shared_access_policies

  iothub_dps_shared_access_policy_name = each.value["iothub_dps_shared_access_policy_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  iothub_dps_name = try(
    element([for _, iothub_dps in module.iothub_dps : iothub_dps.name if iothub_dps.name == each.value["iothub_dps_name"]], 0),
    each.value["iothub_dps_name"]
  )
  enrollment_read    = try(each.value["enrollment_read"], null)
  enrollment_write   = try(each.value["enrollment_write"], null)
  registration_read  = try(each.value["registration_read"], null)
  registration_write = try(each.value["registration_write"], null)
  service_config     = try(each.value["service_config"], null)
  timeouts           = try(each.value["timeouts"], null)
}
