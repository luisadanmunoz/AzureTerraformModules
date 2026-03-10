################################################################################
# Digital Twins Outputs
################################################################################

output "id" {
  description = "The ID of the Digital Twins instance."
  value       = var.create ? azurerm_digital_twins_instance.this[0].id : null
}

output "name" {
  description = "The name of the Digital Twins instance."
  value       = var.create ? azurerm_digital_twins_instance.this[0].name : null
}

output "host_name" {
  description = "The hostname of the Digital Twins instance."
  value       = var.create ? azurerm_digital_twins_instance.this[0].host_name : null
}

################################################################################
# Identity Outputs
################################################################################

output "principal_id" {
  description = "The principal ID of the system-assigned managed identity."
  value       = var.create ? try(azurerm_digital_twins_instance.this[0].identity[0].principal_id, null) : null
}

output "tenant_id" {
  description = "The tenant ID of the system-assigned managed identity."
  value       = var.create ? try(azurerm_digital_twins_instance.this[0].identity[0].tenant_id, null) : null
}
