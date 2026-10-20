#############################################################################
# OUTPUT KEY VAULT
#############################################################################
output "id" {
  value = azurerm_key_vault.key_vault.id
}

output "name" {
  value = azurerm_key_vault.key_vault.name
}

output "vault_uri" {
  value = azurerm_key_vault.key_vault.vault_uri
}
