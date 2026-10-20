#############################################################################
# NETWORK WATCHERS
#############################################################################
module "network_watcher" {
  source = "./modules/network_watcher"

  for_each = var.network_watchers

  network_watcher_name = each.value["network_watcher_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location = each.value["location"]
  tags     = try(each.value["tags"], var.tags)
}
