################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Virtual Machine Scale Set."
  value       = var.create ? (local.is_linux ? azurerm_linux_virtual_machine_scale_set.this[0].id : azurerm_windows_virtual_machine_scale_set.this[0].id) : null
}

output "name" {
  description = "The name of the Virtual Machine Scale Set."
  value       = var.create ? local.resource_name : null
}

output "unique_id" {
  description = "The unique ID of the Virtual Machine Scale Set."
  value       = var.create ? (local.is_linux ? azurerm_linux_virtual_machine_scale_set.this[0].unique_id : azurerm_windows_virtual_machine_scale_set.this[0].unique_id) : null
}

output "identity" {
  description = "The identity block of the VMSS."
  value       = var.create && var.identity != null ? (local.is_linux ? azurerm_linux_virtual_machine_scale_set.this[0].identity : azurerm_windows_virtual_machine_scale_set.this[0].identity) : null
}

output "principal_id" {
  description = "The Principal ID of the System Assigned Managed Identity."
  value = var.create && var.identity != null ? (
    local.is_linux ? try(azurerm_linux_virtual_machine_scale_set.this[0].identity[0].principal_id, null) : try(azurerm_windows_virtual_machine_scale_set.this[0].identity[0].principal_id, null)
  ) : null
}

output "admin_username" {
  description = "The admin username."
  value       = var.admin_username
}

output "admin_password" {
  description = "The admin password (if generated)."
  value       = var.create && local.use_generated_password ? random_password.admin[0].result : null
  sensitive   = true
}

output "autoscale_setting_id" {
  description = "The ID of the Autoscale Setting."
  value       = var.create && var.autoscale.enabled ? azurerm_monitor_autoscale_setting.this[0].id : null
}

output "os_type" {
  description = "The OS type of the VMSS."
  value       = var.os_type
}

output "sku" {
  description = "The SKU of the VMSS."
  value       = var.sku
}

output "instances" {
  description = "The number of instances."
  value       = var.instances
}
