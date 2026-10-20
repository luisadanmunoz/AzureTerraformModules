################################################################################
# DDoS Protection Plan Outputs
################################################################################

output "id" {
  description = "The ID of the DDoS Protection Plan."
  value       = var.create ? azurerm_network_ddos_protection_plan.this[0].id : null
}

output "name" {
  description = "The name of the DDoS Protection Plan."
  value       = var.create ? azurerm_network_ddos_protection_plan.this[0].name : null
}

output "virtual_network_ids" {
  description = "List of VNet IDs associated with this plan."
  value       = var.create ? azurerm_network_ddos_protection_plan.this[0].virtual_network_ids : null
}
