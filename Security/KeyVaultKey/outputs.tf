################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Key Vault Key."
  value       = var.create ? azurerm_key_vault_key.this[0].id : null
}

output "name" {
  description = "The name of the Key Vault Key."
  value       = var.create ? azurerm_key_vault_key.this[0].name : null
}

output "version" {
  description = "The current version of the Key Vault Key."
  value       = var.create ? azurerm_key_vault_key.this[0].version : null
}

output "versionless_id" {
  description = "The versionless ID of the Key Vault Key."
  value       = var.create ? azurerm_key_vault_key.this[0].versionless_id : null
}

output "resource_id" {
  description = "The Resource ID of the Key Vault Key."
  value       = var.create ? azurerm_key_vault_key.this[0].resource_id : null
}

output "resource_versionless_id" {
  description = "The versionless Resource ID of the Key Vault Key."
  value       = var.create ? azurerm_key_vault_key.this[0].resource_versionless_id : null
}

output "public_key_pem" {
  description = "The PEM-encoded public key of the Key Vault Key."
  value       = var.create ? azurerm_key_vault_key.this[0].public_key_pem : null
}

output "public_key_openssh" {
  description = "The OpenSSH-encoded public key of the Key Vault Key."
  value       = var.create ? azurerm_key_vault_key.this[0].public_key_openssh : null
}

output "n" {
  description = "The RSA modulus of the Key Vault Key."
  value       = var.create ? azurerm_key_vault_key.this[0].n : null
}

output "e" {
  description = "The RSA public exponent of the Key Vault Key."
  value       = var.create ? azurerm_key_vault_key.this[0].e : null
}
