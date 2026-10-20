################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Availability Set."
  value       = var.create ? azurerm_availability_set.this[0].id : null
}

output "name" {
  description = "The name of the Availability Set."
  value       = var.create ? azurerm_availability_set.this[0].name : null
}

output "platform_fault_domain_count" {
  description = "The number of fault domains."
  value       = var.create ? azurerm_availability_set.this[0].platform_fault_domain_count : null
}

output "platform_update_domain_count" {
  description = "The number of update domains."
  value       = var.create ? azurerm_availability_set.this[0].platform_update_domain_count : null
}
