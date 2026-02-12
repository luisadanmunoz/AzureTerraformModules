################################################################################
# Storage Sync Service Outputs
################################################################################

output "id" {
  description = "The ID of the Storage Sync Service."
  value       = var.create ? azurerm_storage_sync.this[0].id : null
}

output "name" {
  description = "The name of the Storage Sync Service."
  value       = var.create ? azurerm_storage_sync.this[0].name : null
}

################################################################################
# Sync Group Outputs
################################################################################

output "sync_group_ids" {
  description = "A map of Sync Group names to their IDs."
  value = var.create ? {
    for key, sg in azurerm_storage_sync_group.this : key => sg.id
  } : {}
}

################################################################################
# Cloud Endpoint Outputs
################################################################################

output "cloud_endpoint_ids" {
  description = "A map of Cloud Endpoint keys to their IDs."
  value = var.create ? {
    for key, ce in azurerm_storage_sync_cloud_endpoint.this : key => ce.id
  } : {}
}
