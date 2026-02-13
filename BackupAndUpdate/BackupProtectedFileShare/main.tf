################################################################################
# Storage Account Container Registration
################################################################################

# DEPENDENCY: Recovery Services Vault must exist
# DEPENDENCY: Storage Account must exist
# DEPENDENCY: File Share must exist
# DEPENDENCY: Backup Policy must exist

resource "azurerm_backup_container_storage_account" "this" {
  count = var.create ? 1 : 0

  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_vault_name
  storage_account_id  = var.source_storage_account_id
}

################################################################################
# Backup Protected File Share
################################################################################

resource "azurerm_backup_protected_file_share" "this" {
  count = var.create ? 1 : 0

  resource_group_name       = var.resource_group_name
  recovery_vault_name       = var.recovery_vault_name
  source_storage_account_id = azurerm_backup_container_storage_account.this[0].storage_account_id
  source_file_share_name    = var.source_file_share_name
  backup_policy_id          = var.backup_policy_id

  depends_on = [azurerm_backup_container_storage_account.this]
}
