#############################################################################
# OUTPUT CONTAINER APP ENVIRONMENT CERTIFICATE
#############################################################################
output "id" {
  value = azurerm_container_app_environment_certificate.container_app_environment_certificate.id
}

output "name" {
  value = azurerm_container_app_environment_certificate.container_app_environment_certificate.name
}

output "thumbprint" {
  value = azurerm_container_app_environment_certificate.container_app_environment_certificate.thumbprint
}

output "subject_name" {
  value = azurerm_container_app_environment_certificate.container_app_environment_certificate.subject_name
}
