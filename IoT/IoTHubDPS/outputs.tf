################################################################################
# IoT Hub DPS Outputs
################################################################################

output "id" {
  description = "The ID of the IoT Hub DPS."
  value       = var.create ? azurerm_iothub_dps.this[0].id : null
}

output "name" {
  description = "The name of the IoT Hub DPS."
  value       = var.create ? azurerm_iothub_dps.this[0].name : null
}

output "service_operations_host_name" {
  description = "The service operations host name of the DPS."
  value       = var.create ? azurerm_iothub_dps.this[0].service_operations_host_name : null
}

output "device_provisioning_host_name" {
  description = "The device provisioning host name of the DPS."
  value       = var.create ? azurerm_iothub_dps.this[0].device_provisioning_host_name : null
}

output "id_scope" {
  description = "The unique identifier scope for the DPS."
  value       = var.create ? azurerm_iothub_dps.this[0].id_scope : null
}

output "allocation_policy" {
  description = "The allocation policy of the DPS."
  value       = var.create ? azurerm_iothub_dps.this[0].allocation_policy : null
}
