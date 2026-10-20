#############################################################################
# KUBERNETES FLEET MANAGERS
#############################################################################
module "kubernetes_fleet_manager" {
  source = "./modules/kubernetes_fleet_manager"

  for_each = var.kubernetes_fleet_managers

  kubernetes_fleet_manager_name = each.value["kubernetes_fleet_manager_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location = each.value["location"]
  timeouts = try(each.value["timeouts"], null)
  tags     = try(each.value["tags"], var.tags)
}
