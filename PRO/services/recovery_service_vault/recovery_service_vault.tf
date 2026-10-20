#############################################################################
# RECOVERY SERVICE VAULT
#############################################################################
resource "azurerm_recovery_services_vault" "azurerm_recovery_services_vault" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  storage_mode_type   = "LocallyRedundant" #Solo disponible en SpainCentral

  tags = var.tags
}
#############################################################################
# RECOVERY SERVICE VAULT OUTPUT POLICY VM
#############################################################################
resource "azurerm_backup_policy_vm" "azurerm_recovery_services_vault" {
  name                = var.name_policy
  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_vault_name

  timezone = var.timezone

  backup {
    frequency = var.frequency
    time      = var.time
  }
  retention_daily {
    count = var.retention_daily
  }
  /*
  retention_weekly {
    count    = var.retention_weekly
    weekdays = var.weekdays_weekly
  }
  retention_monthly {
    count    = var.retention_monthly
    weekdays = var.weekdays_monthly
    weeks    = var.weeks_monthly
  }
  retention_yearly {
    count    = var.retention_yearly
    weekdays = var.retention_yearly_weekdays
    weeks    = var.retention_yearly_weeks
    months   = var.retention_yearly_months
  }
*/
  depends_on = [azurerm_recovery_services_vault.azurerm_recovery_services_vault]
}
/*
#############################################################################
# DIAGNOSTIC SETTINGS
#############################################################################
data "azurerm_monitor_diagnostic_categories" "diagnostic_setting" {
  resource_id = azurerm_recovery_services_vault.azurerm_recovery_services_vault.id
}
resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name               = var.name_diagnostic_setting
  target_resource_id = azurerm_recovery_services_vault.azurerm_recovery_services_vault.id
  log_analytics_workspace_id = var.workspace_resource_id
  
  dynamic "enabled_log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.diagnostic_setting.log_category_types
    content {
      category = entry.value
      #enabled  = true
    }
  }
  dynamic "metric" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.diagnostic_setting.metrics 
    content {
      category = entry.value
      enabled  = true
    }
  }

  lifecycle {
    ignore_changes = [ log, metric ]
  }
*/





