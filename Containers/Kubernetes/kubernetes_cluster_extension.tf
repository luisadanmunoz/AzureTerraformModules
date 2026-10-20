#############################################################################
# KUBERNETES CLUSTER EXTENSIONS
#############################################################################
module "kubernetes_cluster_extension" {
  source = "./modules/kubernetes_cluster_extension"

  for_each = var.kubernetes_cluster_extensions

  kubernetes_cluster_extension_name = each.value["kubernetes_cluster_extension_name"]
  cluster_id = try(
    element([for _, kubernetes_cluster in module.kubernetes_cluster : kubernetes_cluster.id if kubernetes_cluster.name == each.value["kubernetes_cluster_name"]], 0),
    each.value["cluster_id"]
  )
  extension_type                   = each.value["extension_type"]
  configuration_settings           = try(each.value["configuration_settings"], null)
  configuration_protected_settings = try(each.value["configuration_protected_settings"], null)
  release_namespace                = try(each.value["release_namespace"], null)
  release_train                    = try(each.value["release_train"], null)
  target_namespace                 = try(each.value["target_namespace"], null)
  extension_version                = try(each.value["extension_version"], null)
  plan                             = try(each.value["plan"], null)
  timeouts                         = try(each.value["timeouts"], null)
}
