output "id" {
  description = "The ID of the Event Grid Subscription."
  value       = try(azurerm_eventgrid_event_subscription.this[0].id, null)
}

output "name" {
  description = "The name of the Event Grid Subscription."
  value       = try(azurerm_eventgrid_event_subscription.this[0].name, null)
}
