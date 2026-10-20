#############################################################################
# COGNITIVE ACCOUNT PROJECT
#############################################################################
resource "azurerm_cognitive_account_project" "cognitive_account_project" {
  name                 = var.cognitive_account_project_name
  cognitive_account_id = var.cognitive_account_id
  location             = var.location
  description          = var.description
  display_name         = var.display_name
  tags                 = var.tags

  identity {
    type         = var.identity["type"]
    identity_ids = try(var.identity["identity_ids"], null)
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
