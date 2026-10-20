#############################################################################
# OUTPUTS IOT HUB ENRICHMENT
#############################################################################
output "id" {
  description = "value of the iot hub enrichment id"
  value       = azurerm_iothub_enrichment.iothub_enrichment.id
}

output "key" {
  description = "value of the iot hub enrichment key"
  value       = azurerm_iothub_enrichment.iothub_enrichment.key
}
