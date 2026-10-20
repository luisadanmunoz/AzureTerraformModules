#############################################################################
# RESOURCE GROUP OUTPUT
#############################################################################		
output "id" {
  description = "value of the id resource group"
  value       = azurerm_resource_group.resource_group.id
}

output "name" {
  description = "value of the name resource group"
  value       = var.resource_group_name
}