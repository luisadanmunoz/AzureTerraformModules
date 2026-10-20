################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Virtual Machine."
  value       = var.create ? (local.is_linux ? azurerm_linux_virtual_machine.this[0].id : azurerm_windows_virtual_machine.this[0].id) : null
}

output "name" {
  description = "The name of the Virtual Machine."
  value       = var.create ? local.resource_name : null
}

output "computer_name" {
  description = "The computer name of the Virtual Machine."
  value       = var.create ? local.computer_name : null
}

output "private_ip_address" {
  description = "The primary private IP address of the Virtual Machine."
  value       = var.create ? (local.is_linux ? azurerm_linux_virtual_machine.this[0].private_ip_address : azurerm_windows_virtual_machine.this[0].private_ip_address) : null
}

output "private_ip_addresses" {
  description = "All private IP addresses of the Virtual Machine."
  value       = var.create ? (local.is_linux ? azurerm_linux_virtual_machine.this[0].private_ip_addresses : azurerm_windows_virtual_machine.this[0].private_ip_addresses) : null
}

output "public_ip_address" {
  description = "The public IP address of the Virtual Machine."
  value       = var.create ? (local.is_linux ? azurerm_linux_virtual_machine.this[0].public_ip_address : azurerm_windows_virtual_machine.this[0].public_ip_address) : null
}

output "public_ip_addresses" {
  description = "All public IP addresses of the Virtual Machine."
  value       = var.create ? (local.is_linux ? azurerm_linux_virtual_machine.this[0].public_ip_addresses : azurerm_windows_virtual_machine.this[0].public_ip_addresses) : null
}

output "network_interface_id" {
  description = "The ID of the created Network Interface."
  value       = var.create && local.create_nic ? azurerm_network_interface.this[0].id : null
}

output "identity" {
  description = "The identity block of the Virtual Machine."
  value       = var.create && var.identity != null ? (local.is_linux ? azurerm_linux_virtual_machine.this[0].identity : azurerm_windows_virtual_machine.this[0].identity) : null
}

output "principal_id" {
  description = "The Principal ID of the System Assigned Managed Identity."
  value = var.create && var.identity != null ? (
    local.is_linux ? try(azurerm_linux_virtual_machine.this[0].identity[0].principal_id, null) : try(azurerm_windows_virtual_machine.this[0].identity[0].principal_id, null)
  ) : null
}

output "admin_username" {
  description = "The admin username of the Virtual Machine."
  value       = var.admin_username
}

output "admin_password" {
  description = "The admin password of the Virtual Machine (if generated)."
  value       = var.create && local.use_generated_password ? random_password.admin[0].result : null
  sensitive   = true
}

output "os_type" {
  description = "The OS type of the Virtual Machine."
  value       = var.os_type
}

output "size" {
  description = "The size (SKU) of the Virtual Machine."
  value       = var.size
}

output "zone" {
  description = "The Availability Zone of the Virtual Machine."
  value       = var.zone
}

output "data_disk_ids" {
  description = "The IDs of the attached data disks."
  value       = var.create ? { for k, v in azurerm_managed_disk.data : k => v.id } : {}
}
