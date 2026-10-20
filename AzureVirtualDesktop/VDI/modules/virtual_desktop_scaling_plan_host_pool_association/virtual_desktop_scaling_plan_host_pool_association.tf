#############################################################################
# VIRTUAL DESKTOP SCALING PLAN HOST POOL ASSOCIATION
#############################################################################
resource "azurerm_virtual_desktop_scaling_plan_host_pool_association" "virtual_desktop_scaling_plan_host_pool_association" {
  host_pool_id    = var.host_pool_id
  scaling_plan_id = var.scaling_plan_id
  enabled         = var.enabled

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
