#############################################################################
# KUBERNETES CLUSTER TRUSTED ACCESS ROLE BINDING
#############################################################################
resource "azurerm_kubernetes_cluster_trusted_access_role_binding" "kubernetes_cluster_trusted_access_role_binding" {
  name                  = var.kubernetes_cluster_trusted_access_role_binding_name
  kubernetes_cluster_id = var.kubernetes_cluster_id
  roles                 = var.roles
  source_resource_id    = var.source_resource_id

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      update = try(timeouts.value["update"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }
}
