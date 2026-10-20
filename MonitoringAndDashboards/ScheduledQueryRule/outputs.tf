################################################################################
# Scheduled Query Rule Alert Outputs
################################################################################

output "id" {
  description = "The ID of the Scheduled Query Rule Alert."
  value       = var.create ? azurerm_monitor_scheduled_query_rules_alert_v2.this[0].id : null
}

output "name" {
  description = "The name of the Scheduled Query Rule Alert."
  value       = var.create ? azurerm_monitor_scheduled_query_rules_alert_v2.this[0].name : null
}
