#############################################################################
# OUTPUT MANAGEMENT GROUP
#############################################################################
output "id" {
  value = azurerm_management_group.management_group.id
}

output "name" {
  value = var.management_group_name
}
