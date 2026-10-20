#############################################################################
# CONTAINER APP JOBS
#############################################################################
module "container_app_job" {
  source = "./modules/container_app_job"

  for_each = var.container_app_jobs

  container_app_job_name = each.value["container_app_job_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location = each.value["location"]
  container_app_environment_id = try(
    element([for _, container_app_environment in module.container_app_environment : container_app_environment.id if container_app_environment.name == each.value["container_app_environment_name"]], 0),
    each.value["container_app_environment_id"]
  )
  workload_profile_name      = try(each.value["workload_profile_name"], null)
  replica_retry_limit        = try(each.value["replica_retry_limit"], null)
  replica_timeout_in_seconds = each.value["replica_timeout_in_seconds"]
  identity                   = try(each.value["identity"], null)
  registry                   = try(each.value["registry"], null)
  secret                     = try(each.value["secret"], null)
  manual_trigger_config      = try(each.value["manual_trigger_config"], null)
  event_trigger_config       = try(each.value["event_trigger_config"], null)
  schedule_trigger_config    = try(each.value["schedule_trigger_config"], null)
  template                   = each.value["template"]
  timeouts                   = try(each.value["timeouts"], null)
  tags                       = try(each.value["tags"], var.tags)
}
