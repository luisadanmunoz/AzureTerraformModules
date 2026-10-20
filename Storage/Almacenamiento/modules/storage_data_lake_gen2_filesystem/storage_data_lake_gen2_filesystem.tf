#############################################################################
# STORAGE DATA LAKE GEN2 FILESYSTEM
#############################################################################
resource "azurerm_storage_data_lake_gen2_filesystem" "storage_data_lake_gen2_filesystem" {
  name                     = var.storage_data_lake_gen2_filesystem_name
  storage_account_id       = var.storage_account_id
  default_encryption_scope = var.default_encryption_scope
  properties               = var.properties

  dynamic "ace" {
    for_each = var.ace != null ? var.ace : []

    content {
      id          = try(ace.value["id"], null)
      permissions = ace.value["permissions"]
      scope       = try(ace.value["scope"], null)
      type        = ace.value["type"]
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
