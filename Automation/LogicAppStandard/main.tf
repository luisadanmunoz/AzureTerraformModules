################################################################################
# Logic App Standard
# DEPENDENCY: Resource Group must exist.
# DEPENDENCY: App Service Plan (WS1/WS2/WS3) must exist.
# DEPENDENCY: Storage Account must exist.
################################################################################

resource "azurerm_logic_app_standard" "this" {
  count = var.create ? 1 : 0

  name                       = local.resource_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = var.app_service_plan_id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  storage_account_share_name = var.storage_account_share_name

  enabled                       = var.enabled
  version                       = var.version
  use_extension_bundle          = var.use_extension_bundle
  bundle_version                = var.bundle_version
  https_only                    = var.https_only
  client_affinity_enabled       = var.client_affinity_enabled
  client_certificate_mode       = var.client_certificate_mode
  public_network_access_enabled = var.public_network_access_enabled

  app_settings = var.app_settings

  # VNet Integration
  virtual_network_subnet_id = var.virtual_network_subnet_id

  # ──────────────────────────────────────────────────────────────────────────────
  # Site Config
  # ──────────────────────────────────────────────────────────────────────────────
  site_config {
    always_on                        = var.site_config.always_on
    app_scale_limit                  = var.site_config.app_scale_limit
    ftps_state                       = var.site_config.ftps_state
    health_check_path                = var.site_config.health_check_path
    http2_enabled                    = var.site_config.http2_enabled
    min_tls_version                  = var.site_config.minimum_tls_version
    pre_warmed_instance_count        = var.site_config.pre_warmed_instance_count
    runtime_scale_monitoring_enabled = var.site_config.runtime_scale_monitoring_enabled
    use_32_bit_worker_process        = var.site_config.use_32_bit_worker
    vnet_route_all_enabled           = var.site_config.vnet_route_all_enabled
    websockets_enabled               = var.site_config.websockets_enabled
    elastic_instance_minimum         = var.site_config.elastic_instance_minimum
    dotnet_framework_version         = var.site_config.dotnet_framework_version

    dynamic "ip_restriction" {
      for_each = var.site_config.ip_restriction
      content {
        name                      = ip_restriction.value.name
        action                    = ip_restriction.value.action
        ip_address                = ip_restriction.value.ip_address
        virtual_network_subnet_id = ip_restriction.value.virtual_network_subnet_id
        service_tag               = ip_restriction.value.service_tag
        priority                  = ip_restriction.value.priority
      }
    }

    dynamic "scm_ip_restriction" {
      for_each = var.site_config.scm_ip_restriction
      content {
        name                      = scm_ip_restriction.value.name
        action                    = scm_ip_restriction.value.action
        ip_address                = scm_ip_restriction.value.ip_address
        virtual_network_subnet_id = scm_ip_restriction.value.virtual_network_subnet_id
        service_tag               = scm_ip_restriction.value.service_tag
        priority                  = scm_ip_restriction.value.priority
      }
    }
  }

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

  tags = local.tags
}
