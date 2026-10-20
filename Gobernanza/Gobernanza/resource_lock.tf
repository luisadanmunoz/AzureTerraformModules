#############################################################################
# RESOURCE LOCKS
#############################################################################
module "resource_lock" {
  source = "./modules/resource_lock"

  for_each = var.resource_locks

  lock_name = each.value["lock_name"]
  scope = try(
    element([for _, resource_group in module.rg : resource_group.id if resource_group.name == each.value["resource_group_name"]], 0),
    element([for _, management_group in module.management_group : management_group.id if management_group.name == each.value["management_group_name"]], 0),
    each.value["scope"]
  )
  lock_level = each.value["lock_level"]
  notes      = try(each.value["notes"], null)
}
