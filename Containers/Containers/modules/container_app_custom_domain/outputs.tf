#############################################################################
# OUTPUT CONTAINER APP CUSTOM DOMAIN
#############################################################################
output "id" {
  value = azurerm_container_app_custom_domain.container_app_custom_domain.id
}

output "name" {
  value = azurerm_container_app_custom_domain.container_app_custom_domain.name
}

output "container_app_environment_managed_certificate_id" {
  value = azurerm_container_app_custom_domain.container_app_custom_domain.container_app_environment_managed_certificate_id
}
