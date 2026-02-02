################################################################################
# Private Endpoint
################################################################################

# DEPENDENCY: Resource Group, Subnet, and target resource must exist
resource "azurerm_private_endpoint" "this" {
  count = var.create ? 1 : 0

  name                = local.pe_name
  resource_group_name = var.resource_group_name # DEPENDENCY: Resource Group
  location            = var.location
  subnet_id           = var.subnet_id # DEPENDENCY: Subnet (with private endpoint policies disabled)

  custom_network_interface_name = var.custom_network_interface_name

  # DEPENDENCY: Target PaaS resource must exist
  private_service_connection {
    name                           = var.private_service_connection.name
    private_connection_resource_id = var.private_service_connection.private_connection_resource_id
    is_manual_connection           = var.private_service_connection.is_manual_connection
    subresource_names              = var.private_service_connection.subresource_names
    request_message                = var.private_service_connection.is_manual_connection ? var.private_service_connection.request_message : null
  }

  # DEPENDENCY: Private DNS Zone(s) must exist
  dynamic "private_dns_zone_group" {
    for_each = var.private_dns_zone_group != null ? [var.private_dns_zone_group] : []

    content {
      name                 = private_dns_zone_group.value.name
      private_dns_zone_ids = private_dns_zone_group.value.private_dns_zone_ids # DEPENDENCY: Private DNS Zones
    }
  }

  dynamic "ip_configuration" {
    for_each = var.ip_configuration

    content {
      name               = ip_configuration.value.name
      subresource_name   = ip_configuration.value.subresource_name
      member_name        = ip_configuration.value.member_name
      private_ip_address = ip_configuration.value.private_ip_address
    }
  }

  tags = local.tags
}
