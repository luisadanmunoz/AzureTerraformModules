#############################################################################
# KUBERNETES FLEET UPDATE STRATEGY
#############################################################################
resource "azurerm_kubernetes_fleet_update_strategy" "kubernetes_fleet_update_strategy" {
  name                        = var.kubernetes_fleet_update_strategy_name
  kubernetes_fleet_manager_id = var.kubernetes_fleet_manager_id

  dynamic "stage" {
    for_each = var.stages

    content {
      name                        = stage.value["name"]
      after_stage_wait_in_seconds = try(stage.value["after_stage_wait_in_seconds"], null)

      dynamic "group" {
        for_each = stage.value["groups"]

        content {
          name = group.value["name"]
        }
      }
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
