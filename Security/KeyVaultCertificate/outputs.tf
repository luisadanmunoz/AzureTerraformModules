################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Key Vault Certificate."
  value       = var.create ? azurerm_key_vault_certificate.this[0].id : null
}

output "name" {
  description = "The name of the Key Vault Certificate."
  value       = var.create ? azurerm_key_vault_certificate.this[0].name : null
}

output "version" {
  description = "The current version of the Key Vault Certificate."
  value       = var.create ? azurerm_key_vault_certificate.this[0].version : null
}

output "versionless_id" {
  description = "The versionless ID of the Key Vault Certificate."
  value       = var.create ? azurerm_key_vault_certificate.this[0].versionless_id : null
}

output "certificate_data" {
  description = "The raw certificate data in PEM format."
  value       = var.create ? azurerm_key_vault_certificate.this[0].certificate_data : null
}

output "certificate_data_base64" {
  description = "The Base64 encoded certificate data in PEM format."
  value       = var.create ? azurerm_key_vault_certificate.this[0].certificate_data_base64 : null
}

output "thumbprint" {
  description = "The X509 thumbprint of the certificate in hex format."
  value       = var.create ? azurerm_key_vault_certificate.this[0].thumbprint : null
}

output "secret_id" {
  description = "The ID of the associated Key Vault Secret."
  value       = var.create ? azurerm_key_vault_certificate.this[0].secret_id : null
}

output "resource_manager_id" {
  description = "The Resource Manager ID of the Key Vault Certificate."
  value       = var.create ? azurerm_key_vault_certificate.this[0].resource_manager_id : null
}

output "resource_manager_versionless_id" {
  description = "The versionless Resource Manager ID of the Key Vault Certificate."
  value       = var.create ? azurerm_key_vault_certificate.this[0].resource_manager_versionless_id : null
}
