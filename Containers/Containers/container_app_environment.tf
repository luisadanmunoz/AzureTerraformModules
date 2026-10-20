#############################################################################
# CONTAINER APP ENVIRONMENTS
#############################################################################
module "container_app_environment" {
  source = "./modules/container_app_environment"

  for_each = var.container_app_environments

  container_app_environment_name = each.value["container_app_environment_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                                    = each.value["location"]
  dapr_application_insights_connection_string = try(each.value["dapr_application_insights_connection_string"], null)
  infrastructure_resource_group_name          = try(each.value["infrastructure_resource_group_name"], null)
  infrastructure_subnet_id                    = try(each.value["infrastructure_subnet_id"], null)
  internal_load_balancer_enabled              = try(each.value["internal_load_balancer_enabled"], null)
  log_analytics_workspace_id = try(
    element([for _, log_analytics_workspace in module.log_analytics_workspace : log_analytics_workspace.id if log_analytics_workspace.name == each.value["log_analytics_workspace_name"]], 0),
    each.value["log_analytics_workspace_id"],
    null
  )
  logs_destination        = try(each.value["logs_destination"], null)
  mutual_tls_enabled      = try(each.value["mutual_tls_enabled"], null)
  public_network_access   = try(each.value["public_network_access"], null)
  zone_redundancy_enabled = try(each.value["zone_redundancy_enabled"], null)
  identity                = try(each.value["identity"], null)
  workload_profile        = try(each.value["workload_profile"], null)
  timeouts                = try(each.value["timeouts"], null)
  tags                    = try(each.value["tags"], var.tags)
}
