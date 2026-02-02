################################################################################
# Firewall Policy
################################################################################

resource "azurerm_firewall_policy" "this" {
  count = var.create ? 1 : 0

  name                = local.policy_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku                               = var.sku
  base_policy_id                    = var.base_policy_id
  threat_intelligence_mode          = var.sku != "Basic" ? var.threat_intelligence_mode : null
  private_ip_ranges                 = var.private_ip_ranges
  auto_learn_private_ranges_enabled = var.auto_learn_private_ranges_enabled
  sql_redirect_allowed              = var.sql_redirect_allowed

  # Threat Intelligence Allowlist
  dynamic "threat_intelligence_allowlist" {
    for_each = var.threat_intelligence_allowlist != null && var.sku != "Basic" ? [var.threat_intelligence_allowlist] : []
    content {
      fqdns        = threat_intelligence_allowlist.value.fqdns
      ip_addresses = threat_intelligence_allowlist.value.ip_addresses
    }
  }

  # DNS Configuration
  dynamic "dns" {
    for_each = var.dns != null && var.sku != "Basic" ? [var.dns] : []
    content {
      proxy_enabled = dns.value.proxy_enabled
      servers       = dns.value.servers
    }
  }

  # IDPS (Premium only)
  dynamic "intrusion_detection" {
    for_each = var.intrusion_detection != null && var.sku == "Premium" ? [var.intrusion_detection] : []
    content {
      mode           = intrusion_detection.value.mode
      private_ranges = intrusion_detection.value.private_ranges

      dynamic "signature_overrides" {
        for_each = intrusion_detection.value.signature_overrides
        content {
          id    = signature_overrides.value.id
          state = signature_overrides.value.state
        }
      }

      dynamic "traffic_bypass" {
        for_each = intrusion_detection.value.traffic_bypass
        content {
          name                  = traffic_bypass.value.name
          protocol              = traffic_bypass.value.protocol
          source_addresses      = traffic_bypass.value.source_addresses
          source_ip_groups      = traffic_bypass.value.source_ip_groups
          destination_addresses = traffic_bypass.value.destination_addresses
          destination_ip_groups = traffic_bypass.value.destination_ip_groups
          destination_ports     = traffic_bypass.value.destination_ports
          description           = traffic_bypass.value.description
        }
      }
    }
  }

  # TLS Inspection (Premium only)
  dynamic "tls_certificate" {
    for_each = var.tls_certificate != null && var.sku == "Premium" ? [var.tls_certificate] : []
    content {
      key_vault_secret_id = tls_certificate.value.key_vault_secret_id
      name                = tls_certificate.value.name
    }
  }

  # Identity for Key Vault access
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  # Explicit Proxy (Premium only)
  dynamic "explicit_proxy" {
    for_each = var.explicit_proxy != null && var.sku == "Premium" ? [var.explicit_proxy] : []
    content {
      enabled         = explicit_proxy.value.enabled
      http_port       = explicit_proxy.value.http_port
      https_port      = explicit_proxy.value.https_port
      enable_pac_file = explicit_proxy.value.enable_pac_file
      pac_file_port   = explicit_proxy.value.pac_file_port
      pac_file        = explicit_proxy.value.pac_file
    }
  }

  # Insights
  dynamic "insights" {
    for_each = var.insights != null ? [var.insights] : []
    content {
      enabled                            = insights.value.enabled
      default_log_analytics_workspace_id = insights.value.default_log_analytics_workspace_id
      retention_in_days                  = insights.value.retention_in_days

      dynamic "log_analytics_workspace" {
        for_each = insights.value.log_analytics_workspaces
        content {
          id                = log_analytics_workspace.value.id
          firewall_location = log_analytics_workspace.value.firewall_location
        }
      }
    }
  }

  tags = local.tags
}
