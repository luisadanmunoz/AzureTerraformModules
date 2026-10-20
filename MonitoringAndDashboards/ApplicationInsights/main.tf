# -----------------------------------------------------------------------------
# Azure Application Insights
# -----------------------------------------------------------------------------
# This module creates an Azure Application Insights resource for application
# performance monitoring and diagnostics.
#
# DEPENDENCIES:
# - Resource group must exist (var.resource_group_name)
# - Log Analytics workspace must exist if workspace_id is provided (var.workspace_id)
# -----------------------------------------------------------------------------

resource "azurerm_application_insights" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = var.application_type

  # Workspace-based Application Insights (recommended)
  workspace_id = var.workspace_id

  # Data cap settings
  daily_data_cap_in_gb                  = var.daily_data_cap_in_gb
  daily_data_cap_notifications_disabled = var.daily_data_cap_notifications_disabled

  # Retention settings (only applicable for classic Application Insights)
  retention_in_days = var.retention_in_days

  # Sampling settings
  sampling_percentage = var.sampling_percentage

  # Privacy and security settings
  disable_ip_masking            = var.disable_ip_masking
  local_authentication_disabled = var.local_authentication_disabled

  # Network access settings
  internet_ingestion_enabled = var.internet_ingestion_enabled
  internet_query_enabled     = var.internet_query_enabled

  # Profiler settings
  force_customer_storage_for_profiler = var.force_customer_storage_for_profiler

  tags = local.tags
}
