#############################################################################
# OUTPUT KEY VAULT SECRET
#############################################################################
output "id" {
  value = azurerm_key_vault_secret.key_vault_secret.id
}

output "name" {
  value = azurerm_key_vault_secret.key_vault_secret.name
}

output "versionless_id" {
  value = azurerm_key_vault_secret.key_vault_secret.versionless_id
}

output "resource_versionless_id" {
  value = azurerm_key_vault_secret.key_vault_secret.resource_versionless_id
}
