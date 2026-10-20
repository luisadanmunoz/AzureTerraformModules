#############################################################################
# CONTAINER APP ENVIRONMENT DAPR COMPONENTS
#############################################################################
module "container_app_environment_dapr_component" {
  source = "./modules/container_app_environment_dapr_component"

  for_each = var.container_app_environment_dapr_components

  container_app_environment_dapr_component_name = each.value["container_app_environment_dapr_component_name"]
  container_app_environment_id = try(
    element([for _, container_app_environment in module.container_app_environment : container_app_environment.id if container_app_environment.name == each.value["container_app_environment_name"]], 0),
    each.value["container_app_environment_id"]
  )
  component_type    = each.value["component_type"]
  component_version = each.value["version"]
  ignore_errors     = try(each.value["ignore_errors"], null)
  init_timeout      = try(each.value["init_timeout"], null)
  metadata          = try(each.value["metadata"], null)
  scopes            = try(each.value["scopes"], null)
  secret            = try(each.value["secret"], null)
  timeouts          = try(each.value["timeouts"], null)
}
