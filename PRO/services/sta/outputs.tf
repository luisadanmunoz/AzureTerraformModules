#############################################################################

output "name" {
  value = azurerm_storage_account.sta.name

}

output "id" {
  value = azurerm_storage_account.sta.primary_connection_string
}

output "container" {
  value = azurerm_storage_container.container.name
}

output "id_sta" {
  value = azurerm_storage_account.sta.id
}

