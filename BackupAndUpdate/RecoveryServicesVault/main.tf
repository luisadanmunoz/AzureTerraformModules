################################################################################
# Recovery Services Vault
################################################################################

resource "azurerm_recovery_services_vault" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location

  # SKU and Storage
  sku                          = var.sku
  storage_mode_type            = var.storage_mode_type
  cross_region_restore_enabled = var.storage_mode_type == "GeoRedundant" ? var.cross_region_restore_enabled : false

  # Security
  soft_delete_enabled           = var.soft_delete_enabled
  immutability                  = var.immutability
  public_network_access_enabled = var.public_network_access_enabled

  classic_vmware_replication_enabled = var.classic_vmware_replication_enabled

  # Monitoring
  monitoring {
    alerts_for_all_job_failures_enabled            = var.monitoring.alerts_for_all_job_failures_enabled
    alerts_for_critical_operation_failures_enabled = var.monitoring.alerts_for_critical_operation_failures_enabled
  }

  # Identity
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.type == "UserAssigned" || identity.value.type == "SystemAssigned, UserAssigned" ? identity.value.identity_ids : null
    }
  }

  # Encryption (CMK)
  dynamic "encryption" {
    for_each = var.encryption != null ? [var.encryption] : []
    content {
      key_id                            = encryption.value.key_id
      infrastructure_encryption_enabled = encryption.value.infrastructure_encryption_enabled
      use_system_assigned_identity      = encryption.value.use_system_assigned_identity
      user_assigned_identity_id         = encryption.value.use_system_assigned_identity ? null : encryption.value.user_assigned_identity_id
    }
  }

  tags = local.tags
}

################################################################################
# Diagnostic Settings
################################################################################

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = var.create && local.enable_diagnostics ? 1 : 0

  name                           = var.diagnostic_settings.name
  target_resource_id             = azurerm_recovery_services_vault.this[0].id
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

  metric {
    category = "Health"
    enabled  = true
  }
}
