#############################################################################
# KUBERNETES FLEET MEMBER
#############################################################################
resource "azurerm_kubernetes_fleet_member" "kubernetes_fleet_member" {
  name                  = var.kubernetes_fleet_member_name
  kubernetes_fleet_id   = var.kubernetes_fleet_id
  kubernetes_cluster_id = var.kubernetes_cluster_id
  group                 = var.group

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
