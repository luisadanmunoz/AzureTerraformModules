################################################################################
# Azure Storage Table - Multiple Tables (for_each)
################################################################################

# DEPENDENCY: Storage Account must exist before creating this resource
resource "azurerm_storage_table" "multiple" {
  for_each = var.create && local.use_multiple_tables ? var.tables : {}

  name                 = each.key
  storage_account_name = var.storage_account_name # DEPENDENCY: Storage Account

  dynamic "acl" {
    for_each = each.value.acl != null ? each.value.acl : []

    content {
      id = acl.value.id

      dynamic "access_policy" {
        for_each = acl.value.access_policy != null ? [acl.value.access_policy] : []

        content {
          start       = access_policy.value.start
          expiry      = access_policy.value.expiry
          permissions = access_policy.value.permissions
        }
      }
    }
  }
}

################################################################################
# Azure Storage Table - Single Table (count)
################################################################################

# DEPENDENCY: Storage Account must exist before creating this resource
resource "azurerm_storage_table" "single" {
  count = var.create && !local.use_multiple_tables ? 1 : 0

  name                 = local.resource_name
  storage_account_name = var.storage_account_name # DEPENDENCY: Storage Account

  dynamic "acl" {
    for_each = var.acl

    content {
      id = acl.value.id

      dynamic "access_policy" {
        for_each = acl.value.access_policy != null ? [acl.value.access_policy] : []

        content {
          start       = access_policy.value.start
          expiry      = access_policy.value.expiry
          permissions = access_policy.value.permissions
        }
      }
    }
  }
}
