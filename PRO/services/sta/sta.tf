# #############################################################################
# # STORAGE ACCOUNT 
# #############################################################################
resource "azurerm_storage_account" "sta" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  //public_network_access_enabled     = false # Habilitar para el contenedor o permitir mi red
  allow_nested_items_to_be_public = false # Impide que los elementos dentro del contenedor sean públicos de forma individual
  is_hns_enabled                  = true  # Habilitar el Hierarchical Namespace - Permite que la cuenta de almacenamiento se comporte como un sistema de archivos jerárquico


  tags = var.tags

}
# #############################################################################
# # STORAGE ACCOUNT - CONTAINER
# #############################################################################
resource "azurerm_storage_container" "container" {
  name                  = var.container
  storage_account_name  = azurerm_storage_account.sta.name
  container_access_type = "private" # Bloquea el acceso anónimo al contenedor y sus blobs
}
# #############################################################################
# # STORAGE ACCOUNT - PRIVATE ENDPOINT
# #############################################################################
resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "pe-${var.name}"
  location            = azurerm_storage_account.sta.location
  resource_group_name = azurerm_storage_account.sta.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "psc-${var.name}"
    private_connection_resource_id = azurerm_storage_account.sta.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}