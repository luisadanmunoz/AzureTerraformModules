#############################################################################
# OUTPUT KEY VAULT CERTIFICATE
#############################################################################
output "id" {
  value = azurerm_key_vault_certificate.key_vault_certificate.id
}

output "name" {
  value = azurerm_key_vault_certificate.key_vault_certificate.name
}

output "versionless_id" {
  value = azurerm_key_vault_certificate.key_vault_certificate.versionless_id
}

output "versionless_secret_id" {
  value = azurerm_key_vault_certificate.key_vault_certificate.versionless_secret_id
}
