#############################################################################
# STORAGE QUEUE
#############################################################################
resource "azurerm_storage_queue" "storage_queue" {
  name                 = var.storage_queue_name
  storage_account_id   = var.storage_account_id
  storage_account_name = var.storage_account_id == null ? var.storage_account_name : null
  metadata             = var.metadata

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
      error_message = "The storage_queue requires storage_account_id or storage_account_name."
    }
  }
}
