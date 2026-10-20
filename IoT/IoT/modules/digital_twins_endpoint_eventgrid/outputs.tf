#############################################################################
# OUTPUTS DIGITAL TWINS ENDPOINT EVENTGRID
#############################################################################
output "id" {
  description = "value of the digital twins endpoint eventgrid id"
  value       = azurerm_digital_twins_endpoint_eventgrid.digital_twins_endpoint_eventgrid.id
}

output "name" {
  description = "value of the digital twins endpoint eventgrid name"
  value       = azurerm_digital_twins_endpoint_eventgrid.digital_twins_endpoint_eventgrid.name
}
