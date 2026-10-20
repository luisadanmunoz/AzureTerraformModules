#############################################################################
# STORAGE CONTAINER
#############################################################################
resource "azurerm_storage_container" "storage_container" {
  name                              = var.storage_container_name
  storage_account_id                = var.storage_account_id
  storage_account_name              = var.storage_account_id == null ? var.storage_account_name : null
  container_access_type             = var.container_access_type
  default_encryption_scope          = var.default_encryption_scope
  encryption_scope_override_enabled = var.encryption_scope_override_enabled
  metadata                          = var.metadata

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      update = try(timeouts.value["update"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }

  lifecycle {
    precondition {
      condition     = var.storage_account_id != null || var.storage_account_name != null
      error_message = "The storage_container requires storage_account_id or storage_account_name."
    }
  }
}
