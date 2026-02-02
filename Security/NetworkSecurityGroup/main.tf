################################################################################
# Network Security Group
################################################################################

# DEPENDENCY: Resource Group must exist before creating this resource
resource "azurerm_network_security_group" "this" {
  count = var.create ? 1 : 0

  name                = local.nsg_name
  resource_group_name = var.resource_group_name # DEPENDENCY: Resource Group
  location            = var.location            # DEPENDENCY: Should align with Resource Group location

  tags = local.tags
}

################################################################################
# Network Security Rules
################################################################################

resource "azurerm_network_security_rule" "this" {
  for_each = var.create ? local.all_rules : {}

  name                        = each.key
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this[0].name

  priority  = each.value.priority
  direction = each.value.direction
  access    = each.value.access
  protocol  = each.value.protocol

  # Source configuration
  source_port_range                      = each.value.source_port_range
  source_port_ranges                     = each.value.source_port_ranges
  source_address_prefix                  = each.value.source_address_prefix
  source_address_prefixes                = each.value.source_address_prefixes
  source_application_security_group_ids  = each.value.source_application_security_group_ids

  # Destination configuration
  destination_port_range                      = each.value.destination_port_range
  destination_port_ranges                     = each.value.destination_port_ranges
  destination_address_prefix                  = each.value.destination_address_prefix
  destination_address_prefixes                = each.value.destination_address_prefixes
  destination_application_security_group_ids  = each.value.destination_application_security_group_ids

  description = each.value.description
}

################################################################################
# Diagnostic Settings (Optional)
################################################################################

# DEPENDENCY: Log Analytics Workspace, Storage Account, or Event Hub must exist
resource "azurerm_monitor_diagnostic_setting" "this" {
  count = local.create_diagnostic_settings ? 1 : 0

  name                           = var.diagnostic_settings.name
  target_resource_id             = azurerm_network_security_group.this[0].id
  log_analytics_workspace_id     = var.diagnostic_settings.log_analytics_workspace_id     # DEPENDENCY: Log Analytics
  storage_account_id             = var.diagnostic_settings.storage_account_id             # DEPENDENCY: Storage Account
  eventhub_authorization_rule_id = var.diagnostic_settings.eventhub_authorization_rule_id # DEPENDENCY: Event Hub
  eventhub_name                  = var.diagnostic_settings.eventhub_name

  dynamic "enabled_log" {
    for_each = var.diagnostic_settings.log_categories

    content {
      category = enabled_log.value
    }
  }
}
