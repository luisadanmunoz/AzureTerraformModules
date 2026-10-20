#############################################################################
# OUTPUT MANAGEMENT GROUP
#############################################################################

output "id" {
  description = "The ID of the Management Group."
  value       = azurerm_management_group.Platform.id
}

output "name" {
  description = "value of the name tag"
  value       = azurerm_management_group.Platform.name
}

