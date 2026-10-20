# -----------------------------------------------------------------------------
# Event Grid Domain Outputs
# -----------------------------------------------------------------------------

output "id" {
  description = "The ID of the Event Grid Domain."
  value       = var.create ? azurerm_eventgrid_domain.this[0].id : null
}

output "name" {
  description = "The name of the Event Grid Domain."
  value       = var.create ? azurerm_eventgrid_domain.this[0].name : null
}

output "endpoint" {
  description = "The endpoint of the Event Grid Domain."
  value       = var.create ? azurerm_eventgrid_domain.this[0].endpoint : null
}

output "primary_access_key" {
  description = "The primary access key for the Event Grid Domain."
  value       = var.create ? azurerm_eventgrid_domain.this[0].primary_access_key : null
  sensitive   = true
}

output "secondary_access_key" {
  description = "The secondary access key for the Event Grid Domain."
  value       = var.create ? azurerm_eventgrid_domain.this[0].secondary_access_key : null
  sensitive   = true
}

output "domain_topic_ids" {
  description = "A map of domain topic names to their IDs."
  value = var.create ? {
    for key, topic in azurerm_eventgrid_domain_topic.this : key => topic.id
  } : {}
}

output "principal_id" {
  description = "The Principal ID of the system-assigned managed identity (if enabled)."
  value       = var.create && var.identity != null ? try(azurerm_eventgrid_domain.this[0].identity[0].principal_id, null) : null
}
