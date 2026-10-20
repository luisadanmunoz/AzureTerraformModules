################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Backup Policy."
  value       = try(azurerm_backup_policy_vm.this[0].id, null)
}

output "name" {
  description = "The name of the Backup Policy."
  value       = try(azurerm_backup_policy_vm.this[0].name, null)
}

output "policy_type" {
  description = "The type of the Backup Policy."
  value       = try(azurerm_backup_policy_vm.this[0].policy_type, null)
}

output "backup_frequency" {
  description = "The backup frequency."
  value       = var.create ? var.backup.frequency : null
}

output "retention_daily_count" {
  description = "The number of daily backups retained."
  value       = var.create ? var.retention_daily : null
}
