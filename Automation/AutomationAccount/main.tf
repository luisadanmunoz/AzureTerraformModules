################################################################################
# Automation Account
# DEPENDENCY: Resource Group must exist.
################################################################################

resource "azurerm_automation_account" "this" {
  count = var.create ? 1 : 0

  name                          = local.resource_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku_name                      = var.sku_name
  local_authentication_enabled  = var.local_authentication_enabled
  public_network_access_enabled = var.public_network_access_enabled

  # ──────────────────────────────────────────────────────────────────────────────
  # Identity
  # ──────────────────────────────────────────────────────────────────────────────
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  # ──────────────────────────────────────────────────────────────────────────────
  # Encryption (Customer Managed Key)
  # ──────────────────────────────────────────────────────────────────────────────
  dynamic "encryption" {
    for_each = var.encryption != null ? [var.encryption] : []
    content {
      key_vault_key_id          = encryption.value.key_vault_key_id
      user_assigned_identity_id = encryption.value.user_assigned_identity_id
    }
  }

  tags = local.tags
}

################################################################################
# Private Endpoints
# DEPENDENCY: Subnet must exist.
# DEPENDENCY: Private DNS Zones must exist (if specified).
################################################################################

resource "azurerm_private_endpoint" "this" {
  for_each = var.create ? { for idx, pe in var.private_endpoints : pe.name => pe } : {}

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = each.value.subnet_id

  private_service_connection {
    name                           = "${each.value.name}-connection"
    private_connection_resource_id = azurerm_automation_account.this[0].id
    subresource_names              = each.value.subresource_names
    is_manual_connection           = each.value.is_manual_connection
  }

  dynamic "private_dns_zone_group" {
    for_each = length(each.value.private_dns_zone_ids) > 0 ? [1] : []
    content {
      name                 = "${each.value.name}-dns-zone-group"
      private_dns_zone_ids = each.value.private_dns_zone_ids
    }
  }

  tags = local.tags
}

################################################################################
# Diagnostic Settings
# DEPENDENCY: Log Analytics Workspace, Storage Account, or Event Hub must exist.
################################################################################

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = var.create && var.diagnostic_settings != null ? 1 : 0

  name                           = var.diagnostic_settings.name
  target_resource_id             = azurerm_automation_account.this[0].id
  log_analytics_workspace_id     = var.diagnostic_settings.log_analytics_workspace_id
  storage_account_id             = var.diagnostic_settings.storage_account_id
  eventhub_authorization_rule_id = var.diagnostic_settings.eventhub_authorization_rule_id
  eventhub_name                  = var.diagnostic_settings.eventhub_name

  dynamic "enabled_log" {
    for_each = var.diagnostic_settings.enabled_log_categories
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
