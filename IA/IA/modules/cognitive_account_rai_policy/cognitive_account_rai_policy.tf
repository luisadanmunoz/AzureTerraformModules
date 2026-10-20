#############################################################################
# COGNITIVE ACCOUNT RAI POLICY
#############################################################################
resource "azurerm_cognitive_account_rai_policy" "cognitive_account_rai_policy" {
  name                 = var.cognitive_account_rai_policy_name
  cognitive_account_id = var.cognitive_account_id
  base_policy_name     = var.base_policy_name
  mode                 = var.mode
  tags                 = var.tags

  dynamic "content_filter" {
    for_each = var.content_filter

    content {
      name               = content_filter.value["name"]
      filter_enabled     = content_filter.value["filter_enabled"]
      block_enabled      = content_filter.value["block_enabled"]
      severity_threshold = content_filter.value["severity_threshold"]
      source             = content_filter.value["source"]
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
