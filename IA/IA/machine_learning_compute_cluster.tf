#############################################################################
# MACHINE LEARNING COMPUTE CLUSTERS
#############################################################################
module "machine_learning_compute_cluster" {
  source = "./modules/machine_learning_compute_cluster"

  for_each = var.machine_learning_compute_clusters

  machine_learning_compute_cluster_name = each.value["machine_learning_compute_cluster_name"]
  machine_learning_workspace_id = try(
    element([for _, machine_learning_workspace in module.machine_learning_workspace : machine_learning_workspace.id if machine_learning_workspace.name == each.value["machine_learning_workspace_name"]], 0),
    each.value["machine_learning_workspace_id"]
  )
  location                  = each.value["location"]
  vm_priority               = each.value["vm_priority"]
  vm_size                   = each.value["vm_size"]
  scale_settings            = each.value["scale_settings"]
  description               = try(each.value["description"], null)
  local_auth_enabled        = try(each.value["local_auth_enabled"], null)
  node_public_ip_enabled    = try(each.value["node_public_ip_enabled"], null)
  ssh_public_access_enabled = try(each.value["ssh_public_access_enabled"], null)
  subnet_resource_id        = try(each.value["subnet_resource_id"], null)
  identity                  = try(each.value["identity"], null)
  ssh                       = try(each.value["ssh"], null)
  timeouts                  = try(each.value["timeouts"], null)
  tags                      = try(each.value["tags"], var.tags)
}
