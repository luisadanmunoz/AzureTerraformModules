################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the VM Extension."
  value       = var.create ? azurerm_virtual_machine_extension.this[0].id : null
}

output "name" {
  description = "The name of the VM Extension."
  value       = var.create ? azurerm_virtual_machine_extension.this[0].name : null
}

output "virtual_machine_id" {
  description = "The ID of the Virtual Machine."
  value       = var.virtual_machine_id
}
