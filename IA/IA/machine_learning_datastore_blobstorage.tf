#############################################################################
# MACHINE LEARNING DATASTORE BLOB STORAGE
#############################################################################
module "machine_learning_datastore_blobstorage" {
  source = "./modules/machine_learning_datastore_blobstorage"

  for_each = var.machine_learning_datastore_blobstorages

  machine_learning_datastore_blobstorage_name = each.value["machine_learning_datastore_blobstorage_name"]
  workspace_id = try(
    element([for _, machine_learning_workspace in module.machine_learning_workspace : machine_learning_workspace.id if machine_learning_workspace.name == each.value["machine_learning_workspace_name"]], 0),
    each.value["workspace_id"]
  )
  storage_container_id       = each.value["storage_container_id"]
  account_key                = try(each.value["account_key"], null)
  shared_access_signature    = try(each.value["shared_access_signature"], null)
  description                = try(each.value["description"], null)
  is_default                 = try(each.value["is_default"], null)
  service_data_auth_identity = try(each.value["service_data_auth_identity"], null)
  timeouts                   = try(each.value["timeouts"], null)
  tags                       = try(each.value["tags"], var.tags)
}
