################################################################################
# Private Link Service Outputs
################################################################################

output "id" {
  description = "The ID of the Private Link Service."
  value       = var.create ? azurerm_private_link_service.this[0].id : null
}

output "name" {
  description = "The name of the Private Link Service."
  value       = var.create ? azurerm_private_link_service.this[0].name : null
}

output "alias" {
  description = "The alias of the Private Link Service, used by consumers to create a connection."
  value       = var.create ? azurerm_private_link_service.this[0].alias : null
}
