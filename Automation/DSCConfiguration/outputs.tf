################################################################################
# DSC Configuration Outputs
################################################################################

output "configuration_ids" {
  description = "Map of DSC Configuration names to their IDs."
  value = {
    for name, config in azurerm_automation_dsc_configuration.this :
    name => config.id
  }
}

output "configuration_names" {
  description = "List of created DSC Configuration names."
  value       = keys(azurerm_automation_dsc_configuration.this)
}

output "configuration_states" {
  description = "Map of DSC Configuration names to their states."
  value = {
    for name, config in azurerm_automation_dsc_configuration.this :
    name => config.state
  }
}
