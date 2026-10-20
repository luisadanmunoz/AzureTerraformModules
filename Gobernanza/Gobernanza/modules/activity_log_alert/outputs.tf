#############################################################################
# OUTPUT ACTIVITY LOG ALERT
#############################################################################
output "id" {
  value = azurerm_monitor_activity_log_alert.activity_log_alert.id
}
