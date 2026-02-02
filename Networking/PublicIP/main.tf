################################################################################
# Public IP
################################################################################

# DEPENDENCY: Resource Group must exist before creating this resource
resource "azurerm_public_ip" "this" {
  count = var.create ? 1 : 0

  name                = local.pip_name
  resource_group_name = var.resource_group_name # DEPENDENCY: Resource Group
  location            = var.location            # DEPENDENCY: Should align with Resource Group

  allocation_method       = var.allocation_method
  sku                     = var.sku
  sku_tier                = var.sku_tier
  ip_version              = var.ip_version
  zones                   = var.sku == "Standard" ? var.zones : null
  idle_timeout_in_minutes = var.idle_timeout_in_minutes

  domain_name_label       = var.domain_name_label
  domain_name_label_scope = var.domain_name_label_scope
  reverse_fqdn            = var.reverse_fqdn

  ip_tags             = length(var.ip_tags) > 0 ? var.ip_tags : null
  public_ip_prefix_id = var.public_ip_prefix_id # DEPENDENCY: Public IP Prefix
  edge_zone           = var.edge_zone

  ddos_protection_mode    = var.ddos_protection_mode
  ddos_protection_plan_id = var.ddos_protection_plan_id # DEPENDENCY: DDoS Protection Plan

  tags = local.tags
}

################################################################################
# Diagnostic Settings (Optional)
################################################################################

# DEPENDENCY: Log Analytics Workspace, Storage Account, or Event Hub must exist
resource "azurerm_monitor_diagnostic_setting" "this" {
  count = local.create_diagnostic_settings ? 1 : 0

  name                           = var.diagnostic_settings.name
  target_resource_id             = azurerm_public_ip.this[0].id
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
