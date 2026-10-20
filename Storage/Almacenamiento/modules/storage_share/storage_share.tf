#############################################################################
# STORAGE SHARE
#############################################################################
resource "azurerm_storage_share" "storage_share" {
  name                 = var.storage_share_name
  storage_account_id   = var.storage_account_id
  storage_account_name = var.storage_account_id == null ? var.storage_account_name : null
  quota                = var.quota
  access_tier          = var.access_tier
  enabled_protocol     = var.enabled_protocol
  metadata             = var.metadata

  dynamic "acl" {
    for_each = var.acl != null ? var.acl : []

    content {
      id = acl.value["id"]

      dynamic "access_policy" {
        for_each = try(acl.value["access_policy"], null) != null ? [acl.value["access_policy"]] : []

        content {
          start       = try(access_policy.value["start"], null)
          expiry      = try(access_policy.value["expiry"], null)
          permissions = access_policy.value["permissions"]
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

  lifecycle {
    precondition {
      condition     = var.storage_account_id != null || var.storage_account_name != null
      error_message = "The storage_share requires storage_account_id or storage_account_name."
    }
  }
}
