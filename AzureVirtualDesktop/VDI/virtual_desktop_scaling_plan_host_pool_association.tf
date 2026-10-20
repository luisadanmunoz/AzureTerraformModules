#############################################################################
# VIRTUAL DESKTOP SCALING PLAN HOST POOL ASSOCIATIONS
#############################################################################
module "virtual_desktop_scaling_plan_host_pool_association" {
  source = "./modules/virtual_desktop_scaling_plan_host_pool_association"

  for_each = var.virtual_desktop_scaling_plan_host_pool_associations

  scaling_plan_id = try(
    element([for _, scaling_plan in module.virtual_desktop_scaling_plan : scaling_plan.id if scaling_plan.name == each.value["virtual_desktop_scaling_plan_name"]], 0),
    each.value["scaling_plan_id"]
  )
  host_pool_id = try(
    element([for _, host_pool in module.virtual_desktop_host_pool : host_pool.id if host_pool.name == each.value["virtual_desktop_host_pool_name"]], 0),
    each.value["host_pool_id"]
  )
  enabled  = each.value["enabled"]
  timeouts = try(each.value["timeouts"], null)
}
