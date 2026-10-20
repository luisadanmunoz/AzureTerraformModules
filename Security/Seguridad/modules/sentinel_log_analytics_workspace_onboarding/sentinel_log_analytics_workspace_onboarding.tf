#############################################################################
# SENTINEL LOG ANALYTICS WORKSPACE ONBOARDING
#############################################################################
resource "azurerm_sentinel_log_analytics_workspace_onboarding" "sentinel_log_analytics_workspace_onboarding" {
  workspace_id                 = var.workspace_id
  customer_managed_key_enabled = var.customer_managed_key_enabled

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }
}
