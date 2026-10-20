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

output "os_type" {
  description = "The OS type of the VM."
  value       = var.os_type
}
