#############################################################################
# KUBERNETES CLUSTER EXTENSION
#############################################################################
resource "azurerm_kubernetes_cluster_extension" "kubernetes_cluster_extension" {
  name                             = var.kubernetes_cluster_extension_name
  cluster_id                       = var.cluster_id
  extension_type                   = var.extension_type
  configuration_settings           = var.configuration_settings
  configuration_protected_settings = var.configuration_protected_settings
  release_namespace                = var.release_namespace
  release_train                    = var.release_train
  target_namespace                 = var.target_namespace
  version                          = var.extension_version

  dynamic "plan" {
    for_each = var.plan != null ? [var.plan] : []

    content {
      name           = plan.value["name"]
      product        = plan.value["product"]
      publisher      = plan.value["publisher"]
      promotion_code = try(plan.value["promotion_code"], null)
      version        = try(plan.value["version"], null)
    }
  }

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
