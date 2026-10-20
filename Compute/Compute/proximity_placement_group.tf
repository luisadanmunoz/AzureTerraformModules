#############################################################################
# PROXIMITY PLACEMENT GROUPS
#############################################################################
module "proximity_placement_group" {
  source = "./modules/proximity_placement_group"

  for_each = var.proximity_placement_groups

  proximity_placement_group_name = each.value["proximity_placement_group_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location         = each.value["location"]
  allowed_vm_sizes = try(each.value["allowed_vm_sizes"], null)
  zone             = try(each.value["zone"], null)
  timeouts         = try(each.value["timeouts"], null)
  tags             = try(each.value["tags"], var.tags)
}
