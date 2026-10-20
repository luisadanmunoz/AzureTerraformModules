#############################################################################
# OUTPUTS DIGITAL TWINS ENDPOINT EVENTHUB
#############################################################################
output "id" {
  description = "value of the digital twins endpoint eventhub id"
  value       = azurerm_digital_twins_endpoint_eventhub.digital_twins_endpoint_eventhub.id
}

output "name" {
  description = "value of the digital twins endpoint eventhub name"
  value       = azurerm_digital_twins_endpoint_eventhub.digital_twins_endpoint_eventhub.name
}
