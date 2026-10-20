#############################################################################
# CONTAINER REGISTRY
#############################################################################
resource "azurerm_container_registry" "acr" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = "Premium"
  admin_enabled                 = true
  public_network_access_enabled = true
  data_endpoint_enabled         = true

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags

}
#############################################################################
# CONTAINER REGISTRY - PRIVATE ENDPOINT
#############################################################################
resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "pe-${var.name}"
  location            = azurerm_container_registry.acr.location
  resource_group_name = azurerm_container_registry.acr.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "psc-${var.name}"
    private_connection_resource_id = azurerm_container_registry.acr.id
    subresource_names              = ["registry"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "pdnszg-${var.name}"
    private_dns_zone_ids = [var.private_dns_zone_ids]

  }
  tags = var.tags
}