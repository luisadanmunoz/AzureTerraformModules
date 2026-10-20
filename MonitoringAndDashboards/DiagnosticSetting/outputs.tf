################################################################################
# Diagnostic Setting Outputs
################################################################################

output "id" {
  description = "The ID of the Diagnostic Setting."
  value       = var.create ? azurerm_monitor_diagnostic_setting.this[0].id : null
}

output "name" {
  description = "The name of the Diagnostic Setting."
  value       = var.create ? azurerm_monitor_diagnostic_setting.this[0].name : null
}
