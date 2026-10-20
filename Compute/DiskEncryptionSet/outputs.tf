################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Disk Encryption Set."
  value       = var.create ? azurerm_disk_encryption_set.this[0].id : null
}

output "name" {
  description = "The name of the Disk Encryption Set."
  value       = var.create ? azurerm_disk_encryption_set.this[0].name : null
}

output "principal_id" {
  description = "The Principal ID of the System Assigned Managed Identity."
  value       = var.create && var.identity_type == "SystemAssigned" ? azurerm_disk_encryption_set.this[0].identity[0].principal_id : null
}

output "tenant_id" {
  description = "The Tenant ID of the Managed Identity."
  value       = var.create ? azurerm_disk_encryption_set.this[0].identity[0].tenant_id : null
}

output "key_vault_access_policy_id" {
  description = "The ID of the Key Vault Access Policy."
  value       = var.create && var.create_key_vault_access_policy && var.key_vault_id != null ? azurerm_key_vault_access_policy.this[0].id : null
}
