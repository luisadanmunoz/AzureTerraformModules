################################################################################
# Backup Protected VM
################################################################################

resource "azurerm_backup_protected_vm" "this" {
  count = var.create ? 1 : 0

  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_vault_name
  backup_policy_id    = var.backup_policy_id
  source_vm_id        = var.source_vm_id

  include_disk_luns = var.include_disk_luns
  exclude_disk_luns = var.exclude_disk_luns
  protection_state  = var.protection_state
}
