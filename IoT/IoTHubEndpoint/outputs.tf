################################################################################
# Storage Container Endpoint Outputs
################################################################################

output "storage_container_endpoint_id" {
  description = "The ID of the Storage Container endpoint."
  value       = var.create && var.storage_container_endpoint != null ? azurerm_iothub_endpoint_storage_container.this[0].id : null
}

output "storage_container_endpoint_name" {
  description = "The name of the Storage Container endpoint."
  value       = var.create && var.storage_container_endpoint != null ? azurerm_iothub_endpoint_storage_container.this[0].name : null
}

################################################################################
# Event Hub Endpoint Outputs
################################################################################

output "eventhub_endpoint_id" {
  description = "The ID of the Event Hub endpoint."
  value       = var.create && var.eventhub_endpoint != null ? azurerm_iothub_endpoint_eventhub.this[0].id : null
}

output "eventhub_endpoint_name" {
  description = "The name of the Event Hub endpoint."
  value       = var.create && var.eventhub_endpoint != null ? azurerm_iothub_endpoint_eventhub.this[0].name : null
}

################################################################################
# Service Bus Queue Endpoint Outputs
################################################################################

output "servicebus_queue_endpoint_id" {
  description = "The ID of the Service Bus Queue endpoint."
  value       = var.create && var.servicebus_queue_endpoint != null ? azurerm_iothub_endpoint_servicebus_queue.this[0].id : null
}

output "servicebus_queue_endpoint_name" {
  description = "The name of the Service Bus Queue endpoint."
  value       = var.create && var.servicebus_queue_endpoint != null ? azurerm_iothub_endpoint_servicebus_queue.this[0].name : null
}

################################################################################
# Service Bus Topic Endpoint Outputs
################################################################################

output "servicebus_topic_endpoint_id" {
  description = "The ID of the Service Bus Topic endpoint."
  value       = var.create && var.servicebus_topic_endpoint != null ? azurerm_iothub_endpoint_servicebus_topic.this[0].id : null
}

output "servicebus_topic_endpoint_name" {
  description = "The name of the Service Bus Topic endpoint."
  value       = var.create && var.servicebus_topic_endpoint != null ? azurerm_iothub_endpoint_servicebus_topic.this[0].name : null
}

################################################################################
# Cosmos DB Endpoint Outputs
################################################################################

output "cosmosdb_endpoint_id" {
  description = "The ID of the Cosmos DB endpoint."
  value       = var.create && var.cosmosdb_endpoint != null ? azurerm_iothub_endpoint_cosmosdb_account.this[0].id : null
}

output "cosmosdb_endpoint_name" {
  description = "The name of the Cosmos DB endpoint."
  value       = var.create && var.cosmosdb_endpoint != null ? azurerm_iothub_endpoint_cosmosdb_account.this[0].name : null
}
