#############################################################################
# OUTPUTS IOT HUB DPS CERTIFICATE
#############################################################################
output "id" {
  description = "value of the iot hub dps certificate id"
  value       = azurerm_iothub_dps_certificate.iothub_dps_certificate.id
}

output "name" {
  description = "value of the iot hub dps certificate name"
  value       = azurerm_iothub_dps_certificate.iothub_dps_certificate.name
}
