#############################################################################
# CONTAINER APP ENVIRONMENT STORAGES
#############################################################################
module "container_app_environment_storage" {
  source = "./modules/container_app_environment_storage"

  for_each = var.container_app_environment_storages

  container_app_environment_storage_name = each.value["container_app_environment_storage_name"]
  container_app_environment_id = try(
    element([for _, container_app_environment in module.container_app_environment : container_app_environment.id if container_app_environment.name == each.value["container_app_environment_name"]], 0),
    each.value["container_app_environment_id"]
  )
  account_name   = try(each.value["account_name"], null)
  access_key     = try(each.value["access_key"], null)
  share_name     = each.value["share_name"]
  access_mode    = each.value["access_mode"]
  nfs_server_url = try(each.value["nfs_server_url"], null)
  timeouts       = try(each.value["timeouts"], null)
}
