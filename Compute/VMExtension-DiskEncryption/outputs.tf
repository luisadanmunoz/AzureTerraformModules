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

output "volume_type" {
  description = "The volume type being encrypted."
  value       = var.volume_type
}
