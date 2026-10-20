#############################################################################
# OUTPUT AVAILABILITY SET
#############################################################################
output "id" {
  value = azurerm_availability_set.availability_set.id
}

output "name" {
  value = azurerm_availability_set.availability_set.name
}
