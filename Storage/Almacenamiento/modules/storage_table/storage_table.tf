#############################################################################
# STORAGE TABLE
#############################################################################
resource "azurerm_storage_table" "storage_table" {
  name                 = var.storage_table_name
  storage_account_name = var.storage_account_name

  dynamic "acl" {
    for_each = var.acl != null ? var.acl : []

    content {
      id = acl.value["id"]

      dynamic "access_policy" {
        for_each = try(acl.value["access_policy"], null) != null ? [acl.value["access_policy"]] : []

        content {
          start       = access_policy.value["start"]
          expiry      = access_policy.value["expiry"]
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
}
