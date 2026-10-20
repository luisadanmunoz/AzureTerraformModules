################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Dedicated Host Group."
  value       = var.create ? azurerm_dedicated_host_group.this[0].id : null
}

output "name" {
  description = "The name of the Dedicated Host Group."
  value       = var.create ? azurerm_dedicated_host_group.this[0].name : null
}

output "platform_fault_domain_count" {
  description = "The number of fault domains."
  value       = var.create ? azurerm_dedicated_host_group.this[0].platform_fault_domain_count : null
}

output "zone" {
  description = "The Availability Zone."
  value       = var.zone
}
