# ==============================================================================
# Outputs
# ==============================================================================

output "id" {
  description = "The ID of the Event Grid Topic."
  value       = try(azurerm_eventgrid_topic.this[0].id, null)
}

output "name" {
  description = "The name of the Event Grid Topic."
  value       = try(azurerm_eventgrid_topic.this[0].name, null)
}

output "endpoint" {
  description = "The endpoint URI of the Event Grid Topic."
  value       = try(azurerm_eventgrid_topic.this[0].endpoint, null)
}

output "primary_access_key" {
  description = "The primary access key of the Event Grid Topic."
  value       = try(azurerm_eventgrid_topic.this[0].primary_access_key, null)
  sensitive   = true
}

output "secondary_access_key" {
  description = "The secondary access key of the Event Grid Topic."
  value       = try(azurerm_eventgrid_topic.this[0].secondary_access_key, null)
  sensitive   = true
}

output "principal_id" {
  description = "The Principal ID associated with the Managed Service Identity of the Event Grid Topic."
  value       = try(azurerm_eventgrid_topic.this[0].identity[0].principal_id, null)
}
