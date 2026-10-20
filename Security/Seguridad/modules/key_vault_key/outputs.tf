#############################################################################
# OUTPUT KEY VAULT KEY
#############################################################################
output "id" {
  value = azurerm_key_vault_key.key_vault_key.id
}

output "name" {
  value = azurerm_key_vault_key.key_vault_key.name
}

output "versionless_id" {
  value = azurerm_key_vault_key.key_vault_key.versionless_id
}

output "resource_versionless_id" {
  value = azurerm_key_vault_key.key_vault_key.resource_versionless_id
}
