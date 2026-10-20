#############################################################################
# OUTPUTS DIGITAL TWINS TIME SERIES DATABASE CONNECTION
#############################################################################
output "id" {
  description = "value of the digital twins time series database connection id"
  value       = azurerm_digital_twins_time_series_database_connection.digital_twins_time_series_database_connection.id
}

output "name" {
  description = "value of the digital twins time series database connection name"
  value       = azurerm_digital_twins_time_series_database_connection.digital_twins_time_series_database_connection.name
}
