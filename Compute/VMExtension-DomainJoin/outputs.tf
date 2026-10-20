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

output "domain_name" {
  description = "The domain that was joined."
  value       = var.domain_name
}
