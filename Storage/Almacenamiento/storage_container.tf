#############################################################################
# STORAGE CONTAINERS
#############################################################################
module "storage_container" {
  source = "./modules/storage_container"

  for_each = var.storage_containers

  storage_container_name = each.value["storage_container_name"]
  storage_account_id = try(
    element([for _, storage_account in module.storage_account : storage_account.id if storage_account.name == each.value["storage_account_name"]], 0),
    each.value["storage_account_id"],
    null
  )
  storage_account_name              = try(each.value["storage_account_name"], null)
  container_access_type             = try(each.value["container_access_type"], null)
  default_encryption_scope          = try(each.value["default_encryption_scope"], null)
  encryption_scope_override_enabled = try(each.value["encryption_scope_override_enabled"], null)
  metadata                          = try(each.value["metadata"], null)
  timeouts                          = try(each.value["timeouts"], null)
}
