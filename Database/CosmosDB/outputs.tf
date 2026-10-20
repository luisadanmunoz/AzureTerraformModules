# -----------------------------------------------------------------------------
# COSMOS DB ACCOUNT OUTPUTS
# -----------------------------------------------------------------------------

output "id" {
  description = "The ID of the Cosmos DB Account"
  value       = try(azurerm_cosmosdb_account.this[0].id, null)
}

output "name" {
  description = "The name of the Cosmos DB Account"
  value       = try(azurerm_cosmosdb_account.this[0].name, null)
}

output "endpoint" {
  description = "The endpoint used to connect to the Cosmos DB Account"
  value       = try(azurerm_cosmosdb_account.this[0].endpoint, null)
}

output "read_endpoints" {
  description = "A list of read endpoints available for the Cosmos DB Account"
  value       = try(azurerm_cosmosdb_account.this[0].read_endpoints, null)
}

output "write_endpoints" {
  description = "A list of write endpoints available for the Cosmos DB Account"
  value       = try(azurerm_cosmosdb_account.this[0].write_endpoints, null)
}

output "primary_key" {
  description = "The primary key for the Cosmos DB Account"
  value       = try(azurerm_cosmosdb_account.this[0].primary_key, null)
  sensitive   = true
}

output "secondary_key" {
  description = "The secondary key for the Cosmos DB Account"
  value       = try(azurerm_cosmosdb_account.this[0].secondary_key, null)
  sensitive   = true
}

output "primary_readonly_key" {
  description = "The primary read-only key for the Cosmos DB Account"
  value       = try(azurerm_cosmosdb_account.this[0].primary_readonly_key, null)
  sensitive   = true
}

output "connection_strings" {
  description = "A list of connection strings available for the Cosmos DB Account"
  value       = try(azurerm_cosmosdb_account.this[0].connection_strings, null)
  sensitive   = true
}
