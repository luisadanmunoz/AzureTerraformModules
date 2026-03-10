################################################################################
# Action Group Outputs
################################################################################

output "id" {
  description = "The ID of the Action Group."
  value       = var.create ? azurerm_monitor_action_group.this[0].id : null
}

output "name" {
  description = "The name of the Action Group."
  value       = var.create ? azurerm_monitor_action_group.this[0].name : null
}
