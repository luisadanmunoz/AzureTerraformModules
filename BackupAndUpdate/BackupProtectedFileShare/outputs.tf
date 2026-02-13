################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Backup Protected File Share."
  value       = var.create ? azurerm_backup_protected_file_share.this[0].id : null
}

output "container_id" {
  description = "The ID of the Backup Container Storage Account."
  value       = var.create ? azurerm_backup_container_storage_account.this[0].id : null
}

output "source_file_share_name" {
  description = "The name of the protected file share."
  value       = var.source_file_share_name
}

output "backup_policy_id" {
  description = "The ID of the backup policy used."
  value       = var.backup_policy_id
}
