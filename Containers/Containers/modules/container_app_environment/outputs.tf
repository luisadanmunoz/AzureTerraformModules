#############################################################################
# OUTPUT CONTAINER APP ENVIRONMENT
#############################################################################
output "id" {
  value = azurerm_container_app_environment.container_app_environment.id
}

output "name" {
  value = azurerm_container_app_environment.container_app_environment.name
}

output "default_domain" {
  value = azurerm_container_app_environment.container_app_environment.default_domain
}

output "static_ip_address" {
  value = azurerm_container_app_environment.container_app_environment.static_ip_address
}

output "custom_domain_verification_id" {
  value = azurerm_container_app_environment.container_app_environment.custom_domain_verification_id
}
