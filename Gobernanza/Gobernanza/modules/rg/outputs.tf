#############################################################################
# OUTPUT RESOURCE GROUP
#############################################################################
output "id" {
  value = azurerm_resource_group.resource_group.id
}

output "name" {
  value = var.resource_group_name
}
