################################################################################
# Azure File Share
################################################################################

# DEPENDENCY: Storage Account must exist before creating this resource
resource "azurerm_storage_share" "this" {
  count = var.create ? 1 : 0

  name               = local.resource_name
  storage_account_id = var.storage_account_id # DEPENDENCY: Storage Account
  quota              = var.quota
  access_tier        = var.access_tier
  enabled_protocol   = var.enabled_protocol
  metadata           = var.metadata

  # Access Control List (ACL) entries
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
