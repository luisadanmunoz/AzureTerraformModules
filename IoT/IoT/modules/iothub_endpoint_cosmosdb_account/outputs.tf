#############################################################################
# OUTPUTS IOT HUB ENDPOINT COSMOSDB ACCOUNT
#############################################################################
output "id" {
  description = "value of the iot hub endpoint cosmosdb account id"
  value       = azurerm_iothub_endpoint_cosmosdb_account.iothub_endpoint_cosmosdb_account.id
}

output "name" {
  description = "value of the iot hub endpoint cosmosdb account name"
  value       = azurerm_iothub_endpoint_cosmosdb_account.iothub_endpoint_cosmosdb_account.name
}
