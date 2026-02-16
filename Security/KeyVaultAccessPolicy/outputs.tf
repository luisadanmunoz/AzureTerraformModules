################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Key Vault Access Policy."
  value       = var.create ? azurerm_key_vault_access_policy.this[0].id : null
}

output "object_id" {
  description = "The object ID of the principal for the access policy."
  value       = var.create ? azurerm_key_vault_access_policy.this[0].object_id : null
}

output "tenant_id" {
  description = "The tenant ID of the access policy."
  value       = var.create ? azurerm_key_vault_access_policy.this[0].tenant_id : null
}
