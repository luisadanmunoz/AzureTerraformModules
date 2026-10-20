#############################################################################
# MACHINE LEARNING COMPUTE INSTANCES
#############################################################################
module "machine_learning_compute_instance" {
  source = "./modules/machine_learning_compute_instance"

  for_each = var.machine_learning_compute_instances

  machine_learning_compute_instance_name = each.value["machine_learning_compute_instance_name"]
  machine_learning_workspace_id = try(
    element([for _, machine_learning_workspace in module.machine_learning_workspace : machine_learning_workspace.id if machine_learning_workspace.name == each.value["machine_learning_workspace_name"]], 0),
    each.value["machine_learning_workspace_id"]
  )
  virtual_machine_size   = each.value["virtual_machine_size"]
  authorization_type     = try(each.value["authorization_type"], null)
  description            = try(each.value["description"], null)
  local_auth_enabled     = try(each.value["local_auth_enabled"], null)
  node_public_ip_enabled = try(each.value["node_public_ip_enabled"], null)
  subnet_resource_id     = try(each.value["subnet_resource_id"], null)
  assign_to_user         = try(each.value["assign_to_user"], null)
  identity               = try(each.value["identity"], null)
  ssh                    = try(each.value["ssh"], null)
  timeouts               = try(each.value["timeouts"], null)
  tags                   = try(each.value["tags"], var.tags)
}
