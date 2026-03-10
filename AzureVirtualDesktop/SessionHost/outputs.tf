################################################################################
# Outputs
################################################################################

output "vm_ids" {
  description = "The IDs of the Session Host VMs."
  value       = var.create ? azurerm_windows_virtual_machine.this[*].id : []
}

output "vm_names" {
  description = "The names of the Session Host VMs."
  value       = var.create ? azurerm_windows_virtual_machine.this[*].name : []
}

output "vm_computer_names" {
  description = "The computer names of the Session Host VMs."
  value       = var.create ? azurerm_windows_virtual_machine.this[*].computer_name : []
}

output "private_ip_addresses" {
  description = "The private IP addresses of the Session Host VMs."
  value       = var.create ? azurerm_network_interface.this[*].private_ip_address : []
}

output "network_interface_ids" {
  description = "The IDs of the Network Interfaces."
  value       = var.create ? azurerm_network_interface.this[*].id : []
}

output "identity_principal_ids" {
  description = "The Principal IDs of the System Assigned Identities."
  value       = var.create ? [for vm in azurerm_windows_virtual_machine.this : try(vm.identity[0].principal_id, null)] : []
}

output "admin_username" {
  description = "The admin username for the VMs."
  value       = var.admin_username
}

output "admin_password" {
  description = "The admin password for the VMs (generated if not provided)."
  value       = var.create && var.admin_password == null ? random_password.admin[0].result : var.admin_password
  sensitive   = true
}

output "instance_count" {
  description = "The number of Session Host VMs created."
  value       = var.create ? var.instance_count : 0
}
