################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Backup Protected VM."
  value       = try(azurerm_backup_protected_vm.this[0].id, null)
}

output "source_vm_id" {
  description = "The ID of the protected VM."
  value       = try(azurerm_backup_protected_vm.this[0].source_vm_id, null)
}

output "vm_name" {
  description = "The name of the protected VM."
  value       = var.create ? local.vm_name : null
}

output "backup_policy_id" {
  description = "The ID of the Backup Policy applied."
  value       = try(azurerm_backup_protected_vm.this[0].backup_policy_id, null)
}
