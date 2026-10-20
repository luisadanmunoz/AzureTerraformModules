################################################################################
# AI Search Service Outputs
################################################################################

output "id" {
  description = "The ID of the Search Service."
  value       = var.create ? azurerm_search_service.this[0].id : null
}

output "name" {
  description = "The name of the Search Service."
  value       = var.create ? azurerm_search_service.this[0].name : null
}

output "primary_key" {
  description = "The primary admin key."
  value       = var.create ? azurerm_search_service.this[0].primary_key : null
  sensitive   = true
}

output "secondary_key" {
  description = "The secondary admin key."
  value       = var.create ? azurerm_search_service.this[0].secondary_key : null
  sensitive   = true
}

output "query_keys" {
  description = "The query keys."
  value       = var.create ? azurerm_search_service.this[0].query_keys : null
  sensitive   = true
}

output "identity" {
  description = "The identity block."
  value       = var.create ? azurerm_search_service.this[0].identity : null
}

output "principal_id" {
  description = "The principal ID of the system-assigned identity."
  value       = var.create ? try(azurerm_search_service.this[0].identity[0].principal_id, null) : null
}
