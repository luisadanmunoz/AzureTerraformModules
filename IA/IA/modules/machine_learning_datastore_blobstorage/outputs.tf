#############################################################################
# OUTPUT MACHINE LEARNING DATASTORE BLOB STORAGE
#############################################################################
output "id" {
  value = azurerm_machine_learning_datastore_blobstorage.machine_learning_datastore_blobstorage.id
}

output "name" {
  value = azurerm_machine_learning_datastore_blobstorage.machine_learning_datastore_blobstorage.name
}

output "is_default" {
  value = azurerm_machine_learning_datastore_blobstorage.machine_learning_datastore_blobstorage.is_default
}
