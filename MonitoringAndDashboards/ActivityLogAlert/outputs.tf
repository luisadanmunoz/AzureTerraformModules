################################################################################
# Activity Log Alert Outputs
################################################################################

output "id" {
  description = "The ID of the Activity Log Alert."
  value       = var.create ? azurerm_monitor_activity_log_alert.this[0].id : null
}

output "name" {
  description = "The name of the Activity Log Alert."
  value       = var.create ? azurerm_monitor_activity_log_alert.this[0].name : null
}
