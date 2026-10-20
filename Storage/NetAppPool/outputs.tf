################################################################################
# NetApp Capacity Pool Outputs
################################################################################

output "id" {
  description = "The ID of the NetApp Capacity Pool."
  value       = var.create ? azurerm_netapp_pool.this[0].id : null
}

output "name" {
  description = "The name of the NetApp Capacity Pool."
  value       = var.create ? azurerm_netapp_pool.this[0].name : null
}

output "service_level" {
  description = "The service level of the NetApp Capacity Pool (Standard, Premium, or Ultra)."
  value       = var.create ? azurerm_netapp_pool.this[0].service_level : null
}

output "size_in_tb" {
  description = "The size of the NetApp Capacity Pool in TiB."
  value       = var.create ? azurerm_netapp_pool.this[0].size_in_tb : null
}
