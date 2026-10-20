################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Key Vault."
  value       = var.create ? azurerm_key_vault.this[0].id : null
}

output "name" {
  description = "The name of the Key Vault."
  value       = var.create ? azurerm_key_vault.this[0].name : null
}

output "vault_uri" {
  description = "The URI of the Key Vault."
  value       = var.create ? azurerm_key_vault.this[0].vault_uri : null
}

output "resource_group_name" {
  description = "The resource group name of the Key Vault."
  value       = var.create ? azurerm_key_vault.this[0].resource_group_name : null
}

output "location" {
  description = "The location of the Key Vault."
  value       = var.create ? azurerm_key_vault.this[0].location : null
}

output "tenant_id" {
  description = "The tenant ID of the Key Vault."
  value       = var.create ? azurerm_key_vault.this[0].tenant_id : null
}
