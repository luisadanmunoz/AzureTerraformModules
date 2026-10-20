################################################################################
# Database Migration Project Outputs
################################################################################

output "id" {
  description = "The ID of the Database Migration Project."
  value       = var.create ? azurerm_database_migration_project.this[0].id : null
}

output "name" {
  description = "The name of the Database Migration Project."
  value       = var.create ? azurerm_database_migration_project.this[0].name : null
}
