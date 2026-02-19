################################################################################
# Database Migration Service Outputs
################################################################################

output "id" {
  description = "The ID of the Database Migration Service."
  value       = var.create ? azurerm_database_migration_service.this[0].id : null
}

output "name" {
  description = "The name of the Database Migration Service."
  value       = var.create ? azurerm_database_migration_service.this[0].name : null
}
