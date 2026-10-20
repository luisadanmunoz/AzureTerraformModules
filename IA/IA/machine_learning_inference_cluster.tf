#############################################################################
# MACHINE LEARNING INFERENCE CLUSTERS
#############################################################################
module "machine_learning_inference_cluster" {
  source = "./modules/machine_learning_inference_cluster"

  for_each = var.machine_learning_inference_clusters

  machine_learning_inference_cluster_name = each.value["machine_learning_inference_cluster_name"]
  machine_learning_workspace_id = try(
    element([for _, machine_learning_workspace in module.machine_learning_workspace : machine_learning_workspace.id if machine_learning_workspace.name == each.value["machine_learning_workspace_name"]], 0),
    each.value["machine_learning_workspace_id"]
  )
  location              = each.value["location"]
  kubernetes_cluster_id = each.value["kubernetes_cluster_id"]
  cluster_purpose       = try(each.value["cluster_purpose"], null)
  description           = try(each.value["description"], null)
  identity              = try(each.value["identity"], null)
  ssl                   = try(each.value["ssl"], null)
  timeouts              = try(each.value["timeouts"], null)
  tags                  = try(each.value["tags"], var.tags)
}
