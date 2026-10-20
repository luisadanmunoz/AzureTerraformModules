#############################################################################
# MACHINE LEARNING DATASTORE DATALAKE GEN2
#############################################################################
module "machine_learning_datastore_datalake_gen2" {
  source = "./modules/machine_learning_datastore_datalake_gen2"

  for_each = var.machine_learning_datastore_datalake_gen2s

  machine_learning_datastore_datalake_gen2_name = each.value["machine_learning_datastore_datalake_gen2_name"]
  workspace_id = try(
    element([for _, machine_learning_workspace in module.machine_learning_workspace : machine_learning_workspace.id if machine_learning_workspace.name == each.value["machine_learning_workspace_name"]], 0),
    each.value["workspace_id"]
  )
  storage_container_id  = each.value["storage_container_id"]
  authority_url         = try(each.value["authority_url"], null)
  client_id             = try(each.value["client_id"], null)
  client_secret         = try(each.value["client_secret"], null)
  description           = try(each.value["description"], null)
  service_data_identity = try(each.value["service_data_identity"], null)
  tenant_id             = try(each.value["tenant_id"], null)
  timeouts              = try(each.value["timeouts"], null)
  tags                  = try(each.value["tags"], var.tags)
}
