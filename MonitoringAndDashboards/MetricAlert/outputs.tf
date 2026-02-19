################################################################################
# Metric Alert Outputs
################################################################################

output "id" {
  description = "The ID of the Metric Alert."
  value       = var.create ? azurerm_monitor_metric_alert.this[0].id : null
}

output "name" {
  description = "The name of the Metric Alert."
  value       = var.create ? azurerm_monitor_metric_alert.this[0].name : null
}
