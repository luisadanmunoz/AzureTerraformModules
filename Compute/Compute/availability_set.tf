#############################################################################
# AVAILABILITY SETS
#############################################################################
module "availability_set" {
  source = "./modules/availability_set"

  for_each = var.availability_sets

  availability_set_name = each.value["availability_set_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                     = each.value["location"]
  managed                      = try(each.value["managed"], null)
  platform_fault_domain_count  = try(each.value["platform_fault_domain_count"], null)
  platform_update_domain_count = try(each.value["platform_update_domain_count"], null)
  proximity_placement_group_id = try(
    element([for _, proximity_placement_group in module.proximity_placement_group : proximity_placement_group.id if proximity_placement_group.name == each.value["proximity_placement_group_name"]], 0),
    each.value["proximity_placement_group_id"],
    null
  )
  timeouts = try(each.value["timeouts"], null)
  tags     = try(each.value["tags"], var.tags)
}
