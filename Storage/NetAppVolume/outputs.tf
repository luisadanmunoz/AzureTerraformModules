# -----------------------------------------------------------------------------
# OUTPUTS
# -----------------------------------------------------------------------------

output "id" {
  description = "The ID of the NetApp Volume."
  value       = var.create ? azurerm_netapp_volume.this[0].id : null
}

output "name" {
  description = "The name of the NetApp Volume."
  value       = var.create ? azurerm_netapp_volume.this[0].name : null
}

output "volume_path" {
  description = "The unique file path of the volume."
  value       = var.create ? azurerm_netapp_volume.this[0].volume_path : null
}

output "mount_ip_addresses" {
  description = "The list of IPv4 addresses for mounting the volume."
  value       = var.create ? azurerm_netapp_volume.this[0].mount_ip_addresses : null
}
