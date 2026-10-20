#############################################################################
# OUTPUTS DIGITAL TWINS INSTANCE
#############################################################################
output "id" {
  description = "value of the digital twins instance id"
  value       = azurerm_digital_twins_instance.digital_twins_instance.id
}

output "name" {
  description = "value of the digital twins instance name"
  value       = azurerm_digital_twins_instance.digital_twins_instance.name
}

output "host_name" {
  description = "value of the digital twins instance host name"
  value       = azurerm_digital_twins_instance.digital_twins_instance.host_name
}
