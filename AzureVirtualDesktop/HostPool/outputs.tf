################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the AVD Host Pool."
  value       = try(azurerm_virtual_desktop_host_pool.this[0].id, null)
}

output "name" {
  description = "The name of the AVD Host Pool."
  value       = try(azurerm_virtual_desktop_host_pool.this[0].name, null)
}

output "type" {
  description = "The type of the AVD Host Pool (Personal or Pooled)."
  value       = try(azurerm_virtual_desktop_host_pool.this[0].type, null)
}

output "load_balancer_type" {
  description = "The load balancer type of the Host Pool."
  value       = try(azurerm_virtual_desktop_host_pool.this[0].load_balancer_type, null)
}

output "registration_token" {
  description = "The registration token for the Host Pool."
  value       = try(azurerm_virtual_desktop_host_pool_registration_info.this[0].token, null)
  sensitive   = true
}

output "registration_expiration_date" {
  description = "The expiration date of the registration token."
  value       = try(azurerm_virtual_desktop_host_pool_registration_info.this[0].expiration_date, null)
}
