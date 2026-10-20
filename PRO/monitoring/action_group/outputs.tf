#############################################################################
# ACTION GROUP ACTION OUTPUT
#############################################################################
output "id" {
  description = "value of the id tag"
  value       = azurerm_monitor_action_group.action_group.id

}

output "name" {
  description = "value of the name tag"
  value       = azurerm_monitor_action_group.action_group.name

}