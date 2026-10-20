#############################################################################
# DATA COLLECTION RULE OUTPUT
#############################################################################
output "id_dcr_win" {
  description = "value of the id tag"
  value       = azurerm_monitor_data_collection_rule.dcr_win.id
}

output "id_vminsight" {
  description = "value of the id tag"
  value       = azurerm_monitor_data_collection_rule.dcr_vminsight.id
}

output "name_dcr_win" {
  description = "value of the name tag"
  value       = azurerm_monitor_data_collection_rule.dcr_win.name
}

output "name_vminsight" {
  description = "value of the name tag"
  value       = azurerm_monitor_data_collection_rule.dcr_vminsight.name
}