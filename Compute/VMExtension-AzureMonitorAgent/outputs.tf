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

output "dcr_association_id" {
  description = "The ID of the Data Collection Rule Association."
  value       = var.create && var.data_collection_rule_id != null ? azurerm_monitor_data_collection_rule_association.this[0].id : null
}
