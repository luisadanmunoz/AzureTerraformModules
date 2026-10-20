################################################################################
# Public IPs for Azure Firewall (Optional - created if not provided)
################################################################################

resource "azurerm_public_ip" "this" {
  count = local.create_public_ips ? var.public_ip_count : 0

  name                = "${var.public_ip_name_prefix}-${local.firewall_name}-${format("%03d", count.index + 1)}"
  resource_group_name = var.resource_group_name
  location            = var.location

  allocation_method = "Static"
  sku               = "Standard"
  zones             = var.zones

  tags = local.tags
}

################################################################################
# Azure Firewall
################################################################################

# DEPENDENCY: Resource Group, VNet/Subnet or Virtual Hub must exist
resource "azurerm_firewall" "this" {
  count = var.create ? 1 : 0

  name                = local.firewall_name
  resource_group_name = var.resource_group_name # DEPENDENCY: Resource Group
  location            = var.location

  sku_name = var.sku_name
  sku_tier = var.sku_tier

  firewall_policy_id = var.firewall_policy_id # DEPENDENCY: Firewall Policy (optional)
  dns_servers        = var.dns_servers
  dns_proxy_enabled  = var.dns_proxy_enabled
  threat_intel_mode  = var.sku_tier != "Basic" ? var.threat_intel_mode : null
  private_ip_ranges  = var.private_ip_ranges
  zones              = var.sku_tier != "Basic" ? var.zones : null

  # VNet deployment IP configuration
  dynamic "ip_configuration" {
    for_each = var.sku_name == "AZFW_VNet" && var.subnet_id != null ? [for i, pip_id in local.public_ip_ids : {
      index  = i
      pip_id = pip_id
    }] : []

    content {
      name                 = ip_configuration.value.index == 0 ? "ipconfig-primary" : "ipconfig-${format("%03d", ip_configuration.value.index + 1)}"
      subnet_id            = ip_configuration.value.index == 0 ? var.subnet_id : null # DEPENDENCY: AzureFirewallSubnet (only first config)
      public_ip_address_id = ip_configuration.value.pip_id                            # DEPENDENCY: Public IP
    }
  }

  # Management IP configuration for forced tunneling
  dynamic "management_ip_configuration" {
    for_each = var.management_ip_configuration != null ? [var.management_ip_configuration] : []

    content {
      name                 = "ipconfig-mgmt"
      subnet_id            = management_ip_configuration.value.subnet_id            # DEPENDENCY: AzureFirewallManagementSubnet
      public_ip_address_id = management_ip_configuration.value.public_ip_address_id # DEPENDENCY: Management Public IP
    }
  }

  # Virtual Hub deployment
  dynamic "virtual_hub" {
    for_each = var.sku_name == "AZFW_Hub" && var.virtual_hub != null ? [var.virtual_hub] : []

    content {
      virtual_hub_id  = virtual_hub.value.virtual_hub_id # DEPENDENCY: Virtual Hub
      public_ip_count = virtual_hub.value.public_ip_count
    }
  }

  tags = local.tags
}

################################################################################
# Diagnostic Settings (Optional)
################################################################################

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = local.create_diagnostic_settings ? 1 : 0

  name                           = var.diagnostic_settings.name
  target_resource_id             = azurerm_firewall.this[0].id
  log_analytics_workspace_id     = var.diagnostic_settings.log_analytics_workspace_id
  storage_account_id             = var.diagnostic_settings.storage_account_id
  eventhub_authorization_rule_id = var.diagnostic_settings.eventhub_authorization_rule_id
  eventhub_name                  = var.diagnostic_settings.eventhub_name

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
