################################################################################
# Arc Server Outputs
################################################################################

output "id" {
  description = "The ID of the Arc-enabled server."
  value       = var.create ? azurerm_arc_machine.this[0].id : null
}

output "name" {
  description = "The name of the Arc-enabled server."
  value       = var.create ? azurerm_arc_machine.this[0].name : null
}

output "identity" {
  description = "The identity block of the Arc-enabled server."
  value       = var.create ? azurerm_arc_machine.this[0].identity : null
}

output "principal_id" {
  description = "The principal ID of the system-assigned managed identity."
  value       = var.create ? try(azurerm_arc_machine.this[0].identity[0].principal_id, null) : null
}
