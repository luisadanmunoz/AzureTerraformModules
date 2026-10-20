################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Recovery Services Vault."
  value       = try(azurerm_recovery_services_vault.this[0].id, null)
}

output "name" {
  description = "The name of the Recovery Services Vault."
  value       = try(azurerm_recovery_services_vault.this[0].name, null)
}

output "sku" {
  description = "The SKU of the Vault."
  value       = try(azurerm_recovery_services_vault.this[0].sku, null)
}

output "storage_mode_type" {
  description = "The storage mode type of the Vault."
  value       = try(azurerm_recovery_services_vault.this[0].storage_mode_type, null)
}

output "identity" {
  description = "The identity of the Vault."
  value = try({
    type         = azurerm_recovery_services_vault.this[0].identity[0].type
    principal_id = azurerm_recovery_services_vault.this[0].identity[0].principal_id
    tenant_id    = azurerm_recovery_services_vault.this[0].identity[0].tenant_id
  }, null)
}

output "principal_id" {
  description = "The Principal ID of the System Assigned Identity."
  value       = try(azurerm_recovery_services_vault.this[0].identity[0].principal_id, null)
}
