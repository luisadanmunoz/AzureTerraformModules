################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Key Vault Secret."
  value       = var.create ? azurerm_key_vault_secret.this[0].id : null
}

output "name" {
  description = "The name of the Key Vault Secret."
  value       = var.create ? azurerm_key_vault_secret.this[0].name : null
}

output "version" {
  description = "The current version of the Key Vault Secret."
  value       = var.create ? azurerm_key_vault_secret.this[0].version : null
}

output "versionless_id" {
  description = "The versionless ID of the Key Vault Secret."
  value       = var.create ? azurerm_key_vault_secret.this[0].versionless_id : null
}

output "resource_id" {
  description = "The Resource ID of the Key Vault Secret."
  value       = var.create ? azurerm_key_vault_secret.this[0].resource_id : null
}

output "resource_versionless_id" {
  description = "The versionless Resource ID of the Key Vault Secret."
  value       = var.create ? azurerm_key_vault_secret.this[0].resource_versionless_id : null
}
