#############################################################################
# MACHINE LEARNING DATASTORE FILESHARE
#############################################################################
resource "azurerm_machine_learning_datastore_fileshare" "machine_learning_datastore_fileshare" {
  name                    = var.machine_learning_datastore_fileshare_name
  workspace_id            = var.workspace_id
  storage_fileshare_id    = var.storage_fileshare_id
  account_key             = var.account_key
  shared_access_signature = var.shared_access_signature
  description             = var.description
  service_data_identity   = var.service_data_identity
  tags                    = var.tags

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
      condition = !(
        var.account_key != null &&
        var.shared_access_signature != null
      )
      error_message = "account_key and shared_access_signature cannot be set together."
    }
  }
}
