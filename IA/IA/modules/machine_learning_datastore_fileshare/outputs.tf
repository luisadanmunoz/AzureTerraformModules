#############################################################################
# OUTPUT MACHINE LEARNING DATASTORE FILESHARE
#############################################################################
output "id" {
  value = azurerm_machine_learning_datastore_fileshare.machine_learning_datastore_fileshare.id
}

output "name" {
  value = azurerm_machine_learning_datastore_fileshare.machine_learning_datastore_fileshare.name
}

output "is_default" {
  value = azurerm_machine_learning_datastore_fileshare.machine_learning_datastore_fileshare.is_default
}
