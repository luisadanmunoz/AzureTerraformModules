#############################################################################
# OUTPUTS IOT HUB CERTIFICATE
#############################################################################
output "id" {
  description = "value of the iot hub certificate id"
  value       = azurerm_iothub_certificate.iothub_certificate.id
}

output "name" {
  description = "value of the iot hub certificate name"
  value       = azurerm_iothub_certificate.iothub_certificate.name
}
