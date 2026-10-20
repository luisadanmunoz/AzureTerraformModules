#############################################################################
# KUBERNETES CLUSTER TRUSTED ACCESS ROLE BINDINGS
#############################################################################
module "kubernetes_cluster_trusted_access_role_binding" {
  source = "./modules/kubernetes_cluster_trusted_access_role_binding"

  for_each = var.kubernetes_cluster_trusted_access_role_bindings

  kubernetes_cluster_trusted_access_role_binding_name = each.value["kubernetes_cluster_trusted_access_role_binding_name"]
  kubernetes_cluster_id = try(
    element([for _, kubernetes_cluster in module.kubernetes_cluster : kubernetes_cluster.id if kubernetes_cluster.name == each.value["kubernetes_cluster_name"]], 0),
    each.value["kubernetes_cluster_id"]
  )
  roles              = each.value["roles"]
  source_resource_id = each.value["source_resource_id"]
  timeouts           = try(each.value["timeouts"], null)
}
