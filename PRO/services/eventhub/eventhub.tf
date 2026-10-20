#############################################################################
# EVENTHUB NAMESPACE
#############################################################################
resource "azurerm_eventhub_namespace" "namespace" {
  name                          = var.namespace
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = "Standard"
  capacity                      = 1
  zone_redundant                = true
  public_network_access_enabled = true

  tags = var.tags

}
#############################################################################
# EVENTHUB
#############################################################################
resource "azurerm_eventhub" "eventhub" {
  name                = var.name_eventhub
  namespace_name      = azurerm_eventhub_namespace.namespace.name
  resource_group_name = azurerm_eventhub_namespace.namespace.resource_group_name
  partition_count     = 1
  message_retention   = 1
}
#############################################################################
# EVENTHUB AUTHORIZATION RULE
#############################################################################
resource "azurerm_eventhub_authorization_rule" "authorization_rule" {
  resource_group_name = azurerm_eventhub_namespace.namespace.resource_group_name
  namespace_name      = azurerm_eventhub_namespace.namespace.name
  eventhub_name       = azurerm_eventhub.eventhub.name
  name                = var.name_authorization_rule
  send                = true
}
#############################################################################
# PRIVATE ENDPOINT
#############################################################################
resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "pe-${var.name_eventhub}"
  location            = azurerm_eventhub_namespace.namespace.location
  resource_group_name = azurerm_eventhub_namespace.namespace.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "psc-${var.name_eventhub}"
    private_connection_resource_id = azurerm_eventhub_namespace.namespace.id
    subresource_names              = ["namespace"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "pdnszg-${var.name_eventhub}"
    private_dns_zone_ids = [var.private_dns_zone_ids]

  }
  tags = var.tags
}