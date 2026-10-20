#############################################################################
# MACHINE LEARNING SYNAPSE SPARKS
#############################################################################
module "machine_learning_synapse_spark" {
  source = "./modules/machine_learning_synapse_spark"

  for_each = var.machine_learning_synapse_sparks

  machine_learning_synapse_spark_name = each.value["machine_learning_synapse_spark_name"]
  machine_learning_workspace_id = try(
    element([for _, machine_learning_workspace in module.machine_learning_workspace : machine_learning_workspace.id if machine_learning_workspace.name == each.value["machine_learning_workspace_name"]], 0),
    each.value["machine_learning_workspace_id"]
  )
  location              = each.value["location"]
  synapse_spark_pool_id = each.value["synapse_spark_pool_id"]
  description           = try(each.value["description"], null)
  local_auth_enabled    = try(each.value["local_auth_enabled"], null)
  identity              = try(each.value["identity"], null)
  timeouts              = try(each.value["timeouts"], null)
  tags                  = try(each.value["tags"], var.tags)
}
