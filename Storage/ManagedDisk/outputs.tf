# ------------------------------------------------------------------------------
# MANAGED DISK OUTPUTS
# ------------------------------------------------------------------------------

output "id" {
  description = "The ID of the Managed Disk."
  value       = try(azurerm_managed_disk.this[0].id, null)
}

output "name" {
  description = "The name of the Managed Disk."
  value       = try(azurerm_managed_disk.this[0].name, null)
}

output "disk_size_gb" {
  description = "The size of the Managed Disk in gigabytes."
  value       = try(azurerm_managed_disk.this[0].disk_size_gb, null)
}

output "storage_account_type" {
  description = "The storage account type of the Managed Disk."
  value       = try(azurerm_managed_disk.this[0].storage_account_type, null)
}
