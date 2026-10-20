################################################################################
# Blob Container
################################################################################

# DEPENDENCY: Storage Account must exist before creating this resource
resource "azurerm_storage_container" "this" {
  count = var.create ? 1 : 0

  name               = local.resource_name
  storage_account_id = var.storage_account_id # DEPENDENCY: Storage Account

  container_access_type             = var.container_access_type
  metadata                          = var.metadata
  default_encryption_scope          = var.default_encryption_scope          # DEPENDENCY: Encryption Scope (if set)
  encryption_scope_override_enabled = var.encryption_scope_override_enabled

  # Immutability policy configuration
  # WARNING: Once policy_mode is set to "Locked", it cannot be reversed or removed
  dynamic "immutability_policy" {
    for_each = var.immutability_policy != null ? [var.immutability_policy] : []

    content {
      expiry_in_days = immutability_policy.value.expiry_in_days
      policy_mode    = immutability_policy.value.policy_mode
    }
  }
}
