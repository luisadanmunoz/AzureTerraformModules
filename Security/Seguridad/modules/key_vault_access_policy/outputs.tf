#############################################################################
# OUTPUT KEY VAULT ACCESS POLICY
#############################################################################
output "id" {
  value = azurerm_key_vault_access_policy.key_vault_access_policy.id
}

output "object_id" {
  value = var.object_id
}

output "key_vault_id" {
  value = var.key_vault_id
}
