#############################################################################
# CONTAINER APPS
#############################################################################
module "container_app" {
  source = "./modules/container_app"

  for_each = var.container_apps

  container_app_name = each.value["container_app_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  container_app_environment_id = try(
    element([for _, container_app_environment in module.container_app_environment : container_app_environment.id if container_app_environment.name == each.value["container_app_environment_name"]], 0),
    each.value["container_app_environment_id"]
  )
  revision_mode          = each.value["revision_mode"]
  workload_profile_name  = try(each.value["workload_profile_name"], null)
  max_inactive_revisions = try(each.value["max_inactive_revisions"], null)
  dapr                   = try(each.value["dapr"], null)
  identity               = try(each.value["identity"], null)
  ingress                = try(each.value["ingress"], null)
  registry               = try(each.value["registry"], null)
  secret                 = try(each.value["secret"], null)
  template               = each.value["template"]
  timeouts               = try(each.value["timeouts"], null)
  tags                   = try(each.value["tags"], var.tags)
}
