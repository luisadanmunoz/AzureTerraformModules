################################################################################
# Public IP - Primary
################################################################################

resource "azurerm_public_ip" "this" {
  count = local.create_public_ip ? 1 : 0

  name                = "pip-${local.gateway_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = local.is_az_sku ? "Standard" : "Basic"
  zones               = local.is_az_sku ? ["1", "2", "3"] : null

  tags = local.tags
}

################################################################################
# Public IP - Secondary (Active-Active)
################################################################################

resource "azurerm_public_ip" "secondary" {
  count = local.create_public_ip_secondary ? 1 : 0

  name                = "pip-${local.gateway_name}-secondary"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = local.is_az_sku ? "Standard" : "Basic"
  zones               = local.is_az_sku ? ["1", "2", "3"] : null

  tags = local.tags
}

################################################################################
# Virtual Network Gateway
################################################################################

resource "azurerm_virtual_network_gateway" "this" {
  count = var.create ? 1 : 0

  name                = local.gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location

  type          = var.type
  vpn_type      = var.type == "Vpn" ? var.vpn_type : null
  sku           = var.sku
  generation    = var.type == "Vpn" && var.vpn_type == "RouteBased" ? var.generation : null
  active_active = var.active_active
  enable_bgp    = var.enable_bgp

  private_ip_address_enabled = var.private_ip_address_enabled
  dns_forwarding_enabled     = var.type == "Vpn" ? var.dns_forwarding_enabled : null

  # Primary IP Configuration
  ip_configuration {
    name                          = "ipconfig-primary"
    public_ip_address_id          = local.create_public_ip ? azurerm_public_ip.this[0].id : var.public_ip_id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_id
  }

  # Secondary IP Configuration (Active-Active)
  dynamic "ip_configuration" {
    for_each = var.active_active ? [1] : []
    content {
      name                          = "ipconfig-secondary"
      public_ip_address_id          = local.create_public_ip_secondary ? azurerm_public_ip.secondary[0].id : var.public_ip_id_secondary
      private_ip_address_allocation = "Dynamic"
      subnet_id                     = var.subnet_id
    }
  }

  # BGP Settings
  dynamic "bgp_settings" {
    for_each = var.enable_bgp && var.bgp_settings != null ? [var.bgp_settings] : []
    content {
      asn = bgp_settings.value.asn

      dynamic "peering_addresses" {
        for_each = bgp_settings.value.peering_addresses
        content {
          ip_configuration_name = peering_addresses.value.ip_configuration_name
          apipa_addresses       = peering_addresses.value.apipa_addresses
        }
      }
    }
  }

  # VPN Client Configuration (P2S)
  dynamic "vpn_client_configuration" {
    for_each = var.vpn_client_configuration != null ? [var.vpn_client_configuration] : []
    content {
      address_space        = vpn_client_configuration.value.address_space
      vpn_client_protocols = vpn_client_configuration.value.vpn_client_protocols
      vpn_auth_types       = vpn_client_configuration.value.vpn_auth_types

      aad_tenant   = vpn_client_configuration.value.aad_tenant
      aad_audience = vpn_client_configuration.value.aad_audience
      aad_issuer   = vpn_client_configuration.value.aad_issuer

      radius_server_address = vpn_client_configuration.value.radius_server_address
      radius_server_secret  = vpn_client_configuration.value.radius_server_secret

      dynamic "root_certificate" {
        for_each = vpn_client_configuration.value.root_certificates
        content {
          name             = root_certificate.value.name
          public_cert_data = root_certificate.value.public_cert_data
        }
      }

      dynamic "revoked_certificate" {
        for_each = vpn_client_configuration.value.revoked_certificates
        content {
          name       = revoked_certificate.value.name
          thumbprint = revoked_certificate.value.thumbprint
        }
      }
    }
  }

  # Custom Routes
  dynamic "custom_route" {
    for_each = var.custom_route != null ? [var.custom_route] : []
    content {
      address_prefixes = custom_route.value.address_prefixes
    }
  }

  tags = local.tags
}

################################################################################
# Diagnostic Settings
################################################################################

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = local.create_diagnostic_settings ? 1 : 0

  name                       = var.diagnostic_settings.name
  target_resource_id         = azurerm_virtual_network_gateway.this[0].id
  log_analytics_workspace_id = var.diagnostic_settings.log_analytics_workspace_id
  storage_account_id         = var.diagnostic_settings.storage_account_id

  dynamic "enabled_log" {
    for_each = var.diagnostic_settings.log_categories
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = var.diagnostic_settings.metric_categories
    content {
      category = metric.value
      enabled  = true
    }
  }
}
