# -----------------------------------------------------------------------------
# HPC CACHE OUTPUTS
# -----------------------------------------------------------------------------

output "id" {
  description = "The ID of the HPC Cache."
  value       = try(azurerm_hpc_cache.this[0].id, null)
}

output "name" {
  description = "The name of the HPC Cache."
  value       = try(azurerm_hpc_cache.this[0].name, null)
}

output "mount_addresses" {
  description = "A list of IP addresses used by clients to mount the HPC Cache."
  value       = try(azurerm_hpc_cache.this[0].mount_addresses, [])
}
