#############################################################################
# OUTPUT AI SERVICES
#############################################################################
output "id" {
  value = azurerm_ai_services.ai_services.id
}

output "name" {
  value = azurerm_ai_services.ai_services.name
}

output "endpoint" {
  value = azurerm_ai_services.ai_services.endpoint
}
