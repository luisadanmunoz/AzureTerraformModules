#############################################################################
# VIRTUAL DESKTOP SCALING PLANS
#############################################################################
module "virtual_desktop_scaling_plan" {
  source = "./modules/virtual_desktop_scaling_plan"

  for_each = var.virtual_desktop_scaling_plans

  virtual_desktop_scaling_plan_name = each.value["virtual_desktop_scaling_plan_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location      = each.value["location"]
  time_zone     = each.value["time_zone"]
  friendly_name = try(each.value["friendly_name"], null)
  description   = try(each.value["description"], null)
  exclusion_tag = try(each.value["exclusion_tag"], null)
  host_pool = try([
    for host_pool in each.value["host_pool"] : {
      hostpool_id = try(
        element([for _, resolved_host_pool in module.virtual_desktop_host_pool : resolved_host_pool.id if resolved_host_pool.name == host_pool["virtual_desktop_host_pool_name"]], 0),
        host_pool["hostpool_id"]
      )
      scaling_plan_enabled = host_pool["scaling_plan_enabled"]
    }
  ], null)
  schedule = each.value["schedule"]
  timeouts = try(each.value["timeouts"], null)
  tags     = try(each.value["tags"], var.tags)
}
