################################################################################
# Azure API Management Service
################################################################################

resource "azurerm_api_management" "this" {
  count = var.create ? 1 : 0

  name                      = var.name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  publisher_name            = var.publisher_name
  publisher_email           = var.publisher_email
  sku_name                  = var.sku_name
  min_api_version           = var.min_api_version
  virtual_network_type      = var.virtual_network_type
  notification_sender_email = var.notification_sender_email

  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []
    content {
      type         = var.identity_type
      identity_ids = var.identity_ids
    }
  }

  dynamic "virtual_network_configuration" {
    for_each = var.virtual_network_subnet_id != null ? [1] : []
    content {
      subnet_id = var.virtual_network_subnet_id
    }
  }

  dynamic "protocols" {
    for_each = var.protocols != null ? [var.protocols] : []
    content {
      enable_http2 = protocols.value.enable_http2
    }
  }

  dynamic "security" {
    for_each = var.security != null ? [var.security] : []
    content {
      enable_backend_ssl30  = security.value.enable_backend_ssl30
      enable_backend_tls10  = security.value.enable_backend_tls10
      enable_backend_tls11  = security.value.enable_backend_tls11
      enable_frontend_ssl30 = security.value.enable_frontend_ssl30
      enable_frontend_tls10 = security.value.enable_frontend_tls10
      enable_frontend_tls11 = security.value.enable_frontend_tls11
    }
  }

  tags = local.tags
}
