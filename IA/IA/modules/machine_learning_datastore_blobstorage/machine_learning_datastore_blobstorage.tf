#############################################################################
# MACHINE LEARNING DATASTORE BLOB STORAGE
#############################################################################
resource "azurerm_machine_learning_datastore_blobstorage" "machine_learning_datastore_blobstorage" {
  name                       = var.machine_learning_datastore_blobstorage_name
  workspace_id               = var.workspace_id
  storage_container_id       = var.storage_container_id
  account_key                = var.account_key
  shared_access_signature    = var.shared_access_signature
  description                = var.description
  is_default                 = var.is_default
  service_data_auth_identity = var.service_data_auth_identity
  tags                       = var.tags

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

    precondition {
      condition = (
        try(var.service_data_auth_identity, null) != null &&
        var.service_data_auth_identity != "None"
      ) || var.account_key != null || var.shared_access_signature != null
      error_message = "When service_data_auth_identity is None or omitted, account_key or shared_access_signature must be set."
    }
  }
}
