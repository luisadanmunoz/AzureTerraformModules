# Define el Private Endpoint
#############################################################################
# PRIVATE ENDPOINT
#############################################################################
resource "azurerm_private_endpoint" "private_endpoint" {
  custom_network_interface_name = var.custom_network_interface_name
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id

  private_service_connection {
    name                              = var.name_private_service_connection
    private_connection_resource_alias = var.private_connection_resource_alias ? var.alias : null
    private_connection_resource_id    = var.private_connection_resource_id ? var.id : null
    is_manual_connection              = true
    request_message                   = "IAM"
    subresource_names                 = var.subresource_names == true ? ["${var.subresource}"] : []
  }
}