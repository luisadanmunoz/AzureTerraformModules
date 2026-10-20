################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Maintenance Assignment."
  value = var.create ? coalesce(
    local.is_vm ? azurerm_maintenance_assignment_virtual_machine.this[0].id : null,
    local.is_host ? azurerm_maintenance_assignment_dedicated_host.this[0].id : null,
    local.is_vmss ? azurerm_maintenance_assignment_virtual_machine_scale_set.this[0].id : null,
    local.is_dyn && var.dynamic_scope != null ? azurerm_maintenance_assignment_dynamic_scope.this[0].id : null
  ) : null
}

output "assignment_type" {
  description = "The type of the Maintenance Assignment."
  value       = var.assignment_type
}

output "maintenance_configuration_id" {
  description = "The ID of the associated Maintenance Configuration."
  value       = var.maintenance_configuration_id
}

output "target_resource_id" {
  description = "The ID of the target resource."
  value = var.create ? coalesce(
    var.virtual_machine_id,
    var.dedicated_host_id,
    var.virtual_machine_scale_set_id,
    var.dynamic_scope != null ? var.dynamic_scope.name : null
  ) : null
}
