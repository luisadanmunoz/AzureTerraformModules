# -----------------------------------------------------------------------------
# OUTPUTS
# -----------------------------------------------------------------------------

output "id" {
  description = "The ID of the Event Grid System Topic."
  value       = var.create ? azurerm_eventgrid_system_topic.this[0].id : null
}

output "name" {
  description = "The name of the Event Grid System Topic."
  value       = var.create ? azurerm_eventgrid_system_topic.this[0].name : null
}

output "metric_arm_resource_id" {
  description = "The Metric ARM Resource ID of the Event Grid System Topic."
  value       = var.create ? azurerm_eventgrid_system_topic.this[0].metric_arm_resource_id : null
}

output "principal_id" {
  description = "The Principal ID of the System Assigned Managed Identity. Returns null if identity is not configured or if using UserAssigned identity only."
  value       = var.create && var.identity != null ? try(azurerm_eventgrid_system_topic.this[0].identity[0].principal_id, null) : null
}

output "tenant_id" {
  description = "The Tenant ID of the System Assigned Managed Identity. Returns null if identity is not configured or if using UserAssigned identity only."
  value       = var.create && var.identity != null ? try(azurerm_eventgrid_system_topic.this[0].identity[0].tenant_id, null) : null
}

output "event_subscription_ids" {
  description = "A map of event subscription names to their IDs."
  value       = var.create ? { for k, v in azurerm_eventgrid_system_topic_event_subscription.this : k => v.id } : {}
}

output "resource" {
  description = "The full Event Grid System Topic resource object."
  value       = var.create ? azurerm_eventgrid_system_topic.this[0] : null
}

output "event_subscriptions" {
  description = "A map of event subscription names to their full resource objects."
  value       = var.create ? azurerm_eventgrid_system_topic_event_subscription.this : {}
}
