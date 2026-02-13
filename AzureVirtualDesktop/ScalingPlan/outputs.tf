################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the AVD Scaling Plan."
  value       = try(azurerm_virtual_desktop_scaling_plan.this[0].id, null)
}

output "name" {
  description = "The name of the AVD Scaling Plan."
  value       = try(azurerm_virtual_desktop_scaling_plan.this[0].name, null)
}

output "time_zone" {
  description = "The timezone of the Scaling Plan."
  value       = try(azurerm_virtual_desktop_scaling_plan.this[0].time_zone, null)
}

output "schedule_names" {
  description = "The names of the schedules in the Scaling Plan."
  value       = var.create ? [for s in var.schedules : s.name] : []
}
