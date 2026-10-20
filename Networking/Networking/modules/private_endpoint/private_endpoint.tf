#############################################################################
# PRIVATE ENDPOINT
#############################################################################
resource "azurerm_private_endpoint" "private_endpoint" {
  name                          = var.private_endpoint_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  subnet_id                     = var.subnet_id
  custom_network_interface_name = var.custom_network_interface_name
  tags                          = var.tags

  private_service_connection {
    name                           = coalesce(var.private_service_connection_name, "${var.private_endpoint_name}-psc")
    private_connection_resource_id = var.private_connection_resource_id
    subresource_names              = var.subresource_names
    is_manual_connection           = var.is_manual_connection
    request_message                = var.request_message
  }

  dynamic "private_dns_zone_group" {
    for_each = length(var.private_dns_zone_ids) > 0 ? [1] : []

    content {
      name                 = var.private_dns_zone_group_name
      private_dns_zone_ids = var.private_dns_zone_ids
    }
  }
}
