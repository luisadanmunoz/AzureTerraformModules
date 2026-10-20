#############################################################################
# OUTPUT CONTAINER APP
#############################################################################
output "id" {
  value = azurerm_container_app.container_app.id
}

output "name" {
  value = azurerm_container_app.container_app.name
}

output "latest_revision_name" {
  value = azurerm_container_app.container_app.latest_revision_name
}

output "latest_revision_fqdn" {
  value = azurerm_container_app.container_app.latest_revision_fqdn
}

output "custom_domain_verification_id" {
  value = azurerm_container_app.container_app.custom_domain_verification_id
}
