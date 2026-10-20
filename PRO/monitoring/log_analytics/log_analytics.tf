#############################################################################
# LOG ANALYTICS WORKSPACE
#############################################################################
resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                       = var.name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  sku                        = var.sku
  retention_in_days          = var.retention_in_days
  internet_ingestion_enabled = false
  internet_query_enabled     = false # https://learn.microsoft.com/es-es/azure/azure-monitor/logs/private-link-security#configure-access-to-your-resources

  tags = var.tags
}
