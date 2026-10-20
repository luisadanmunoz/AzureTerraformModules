#############################################################################
# OUTPUT CONTAINER APP ENVIRONMENT CUSTOM DOMAIN
#############################################################################
output "id" {
  value = azurerm_container_app_environment_custom_domain.container_app_environment_custom_domain.id
}

output "dns_suffix" {
  value = var.dns_suffix
}
