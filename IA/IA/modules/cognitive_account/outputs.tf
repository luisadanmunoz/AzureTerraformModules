#############################################################################
# OUTPUT COGNITIVE ACCOUNT
#############################################################################
output "id" {
  value = azurerm_cognitive_account.cognitive_account.id
}

output "name" {
  value = azurerm_cognitive_account.cognitive_account.name
}

output "endpoint" {
  value = azurerm_cognitive_account.cognitive_account.endpoint
}
