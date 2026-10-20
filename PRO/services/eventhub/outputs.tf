#############################################################################
# EVENTHUB NAMESPACE OUTPUT
#############################################################################
output "name" {
  value = azurerm_eventhub.eventhub.name

}

output "id" {
  value = azurerm_eventhub_authorization_rule.authorization_rule.primary_connection_string

}

