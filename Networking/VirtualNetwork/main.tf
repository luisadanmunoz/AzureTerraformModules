################################################################################
# Virtual Network
################################################################################

# DEPENDENCY: Resource Group must exist before creating this resource
resource "azurerm_virtual_network" "this" {
  count = var.create ? 1 : 0

  name                = local.vnet_name
  resource_group_name = var.resource_group_name # DEPENDENCY: Resource Group
  location            = var.location            # DEPENDENCY: Should align with Resource Group location

  address_space           = var.address_space
  dns_servers             = length(var.dns_servers) > 0 ? var.dns_servers : null
  bgp_community           = var.bgp_community
  edge_zone               = var.edge_zone
  flow_timeout_in_minutes = var.flow_timeout_in_minutes

  # DEPENDENCY: DDoS Protection Plan (if enabled)
  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan != null ? [var.ddos_protection_plan] : []

    content {
      id     = ddos_protection_plan.value.id     # DEPENDENCY: DDoS Protection Plan ID
      enable = ddos_protection_plan.value.enable
    }
  }

  # Encryption configuration (preview feature)
  dynamic "encryption" {
    for_each = var.encryption != null ? [var.encryption] : []

    content {
      enforcement = encryption.value.enforcement
    }
  }

  tags = local.tags
}

################################################################################
# Inline Subnets (Optional)
################################################################################

resource "azurerm_subnet" "this" {
  for_each = var.create ? var.subnets : {}

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this[0].name

  address_prefixes                              = each.value.address_prefixes
  private_endpoint_network_policies             = each.value.private_endpoint_network_policies
  private_link_service_network_policies_enabled = each.value.private_link_service_network_policies_enabled
  service_endpoints                             = length(each.value.service_endpoints) > 0 ? each.value.service_endpoints : null

  dynamic "delegation" {
    for_each = each.value.delegation != null ? [each.value.delegation] : []

    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }
}

################################################################################
# Diagnostic Settings (Optional)
################################################################################

# DEPENDENCY: Log Analytics Workspace, Storage Account, or Event Hub must exist
resource "azurerm_monitor_diagnostic_setting" "this" {
  count = local.create_diagnostic_settings ? 1 : 0

  name                           = var.diagnostic_settings.name
  target_resource_id             = azurerm_virtual_network.this[0].id
  log_analytics_workspace_id     = var.diagnostic_settings.log_analytics_workspace_id     # DEPENDENCY: Log Analytics Workspace
  storage_account_id             = var.diagnostic_settings.storage_account_id             # DEPENDENCY: Storage Account
  eventhub_authorization_rule_id = var.diagnostic_settings.eventhub_authorization_rule_id # DEPENDENCY: Event Hub
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
