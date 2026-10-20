################################################################################
# Single Queue Outputs
################################################################################

output "id" {
  description = "The ID of the single Storage Queue (when using count-based creation)."
  value       = var.create && !local.use_multiple_queues ? azurerm_storage_queue.this[0].id : null
}

output "name" {
  description = "The name of the single Storage Queue (when using count-based creation)."
  value       = var.create && !local.use_multiple_queues ? azurerm_storage_queue.this[0].name : null
}

################################################################################
# Multiple Queues Outputs
################################################################################

output "queue_ids" {
  description = "Map of queue names to their IDs (when using for_each-based creation with the queues variable)."
  value = {
    for name, queue in azurerm_storage_queue.multiple :
    name => queue.id
  }
}

output "queue_names" {
  description = "Map of queue keys to their names (when using for_each-based creation with the queues variable)."
  value = {
    for name, queue in azurerm_storage_queue.multiple :
    name => queue.name
  }
}

################################################################################
# Common Outputs
################################################################################

output "storage_account_name" {
  description = "The name of the Storage Account containing the queue(s)."
  value       = var.storage_account_name
}
