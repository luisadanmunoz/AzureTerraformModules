################################################################################
# Azure Container App Environment
################################################################################

# DEPENDENCY: Resource Group must exist
# DEPENDENCY: Log Analytics Workspace must exist (if using monitoring)
# DEPENDENCY: Subnet must exist with delegation (if using VNet integration)
# DEPENDENCY: Application Insights must exist (if using Dapr with AI)

resource "azurerm_container_app_environment" "this" {
  count = var.create ? 1 : 0

  name                = local.name
  resource_group_name = var.resource_group_name
  location            = var.location

  log_analytics_workspace_id = var.log_analytics_workspace_id

  infrastructure_subnet_id                     = var.infrastructure_subnet_id
  internal_load_balancer_enabled               = var.internal_load_balancer_enabled
  zone_redundancy_enabled                      = var.zone_redundancy_enabled
  dapr_application_insights_connection_string  = var.dapr_application_insights_connection_string
  infrastructure_resource_group_name           = var.infrastructure_resource_group_name

  # Workload profiles
  dynamic "workload_profile" {
    for_each = var.workload_profiles

    content {
      name                  = workload_profile.value.name
      workload_profile_type = workload_profile.value.workload_profile_type
      minimum_count         = workload_profile.value.minimum_count
      maximum_count         = workload_profile.value.maximum_count
    }
  }

  tags = local.tags
}

################################################################################
# Dapr Components
################################################################################

resource "azurerm_container_app_environment_dapr_component" "this" {
  for_each = var.create ? { for dc in var.dapr_components : dc.name => dc } : {}

  name                         = each.value.name
  container_app_environment_id = azurerm_container_app_environment.this[0].id
  component_type               = each.value.component_type
  version                      = each.value.version
  ignore_errors                = each.value.ignore_errors
  init_timeout                 = each.value.init_timeout
  scopes                       = each.value.scopes

  dynamic "metadata" {
    for_each = each.value.metadata

    content {
      name        = metadata.value.name
      value       = metadata.value.value
      secret_name = metadata.value.secret_name
    }
  }

  dynamic "secret" {
    for_each = each.value.secret

    content {
      name  = secret.value.name
      value = secret.value.value
    }
  }
}

################################################################################
# Storage
################################################################################

resource "azurerm_container_app_environment_storage" "this" {
  for_each = var.create ? { for s in var.storages : s.name => s } : {}

  name                         = each.value.name
  container_app_environment_id = azurerm_container_app_environment.this[0].id
  account_name                 = each.value.account_name
  share_name                   = each.value.share_name
  access_key                   = each.value.access_key
  access_mode                  = each.value.access_mode
}

################################################################################
# Certificates
################################################################################

resource "azurerm_container_app_environment_certificate" "this" {
  for_each = var.create ? { for c in var.certificates : c.name => c } : {}

  name                         = each.value.name
  container_app_environment_id = azurerm_container_app_environment.this[0].id

  certificate_blob_base64  = each.value.certificate_blob_base64
  certificate_password     = each.value.certificate_password
}
