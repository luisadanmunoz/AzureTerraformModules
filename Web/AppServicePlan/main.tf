# -----------------------------------------------------------------------------
# Azure App Service Plan
# -----------------------------------------------------------------------------
# This module creates an Azure App Service Plan (azurerm_service_plan) which
# defines the compute resources for hosting web applications, function apps,
# and container apps.
# -----------------------------------------------------------------------------

resource "azurerm_service_plan" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name

  # Worker configuration
  worker_count                 = var.worker_count
  maximum_elastic_worker_count = var.maximum_elastic_worker_count

  # App Service Environment deployment
  app_service_environment_id = var.app_service_environment_id

  # Scaling configuration
  per_site_scaling_enabled = var.per_site_scaling_enabled
  zone_balancing_enabled   = var.zone_balancing_enabled

  tags = local.tags
}
