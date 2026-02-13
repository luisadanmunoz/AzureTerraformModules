################################################################################
# Function App
# DEPENDENCY: Resource Group must exist.
# DEPENDENCY: App Service Plan must exist.
# DEPENDENCY: Storage Account must exist.
################################################################################

# ──────────────────────────────────────────────────────────────────────────────
# Linux Function App
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_linux_function_app" "this" {
  count = var.create && local.is_linux ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  storage_account_name          = var.storage_account_name
  storage_account_access_key    = var.storage_uses_managed_identity ? null : var.storage_account_access_key
  storage_uses_managed_identity = var.storage_uses_managed_identity

  functions_extension_version   = var.functions_extension_version
  builtin_logging_enabled       = var.builtin_logging_enabled
  enabled                       = var.enabled
  https_only                    = var.https_only
  public_network_access_enabled = var.public_network_access_enabled
  client_certificate_enabled    = var.client_certificate_enabled
  client_certificate_mode       = var.client_certificate_mode
  virtual_network_subnet_id     = var.virtual_network_subnet_id

  app_settings = var.app_settings

  site_config {
    always_on                              = var.site_config.always_on
    ftps_state                             = var.site_config.ftps_state
    http2_enabled                          = var.site_config.http2_enabled
    minimum_tls_version                    = var.site_config.minimum_tls_version
    use_32_bit_worker                      = var.site_config.use_32_bit_worker
    vnet_route_all_enabled                 = var.site_config.vnet_route_all_enabled
    application_insights_key               = var.site_config.application_insights_key
    application_insights_connection_string = var.site_config.application_insights_connection_string

    dynamic "application_stack" {
      for_each = var.site_config.application_stack != null ? [var.site_config.application_stack] : []
      content {
        dotnet_version              = application_stack.value.dotnet_version
        java_version                = application_stack.value.java_version
        node_version                = application_stack.value.node_version
        python_version              = application_stack.value.python_version
        powershell_core_version     = application_stack.value.powershell_core_version
        use_dotnet_isolated_runtime = application_stack.value.use_dotnet_isolated_runtime
      }
    }

    dynamic "cors" {
      for_each = var.site_config.cors != null ? [var.site_config.cors] : []
      content {
        allowed_origins     = cors.value.allowed_origins
        support_credentials = cors.value.support_credentials
      }
    }

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
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.type == "UserAssigned" || identity.value.type == "SystemAssigned, UserAssigned" ? identity.value.identity_ids : null
    }
  }

  dynamic "connection_string" {
    for_each = var.connection_strings
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  tags = local.tags
}

# ──────────────────────────────────────────────────────────────────────────────
# Windows Function App
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_windows_function_app" "this" {
  count = var.create && local.is_windows ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  storage_account_name          = var.storage_account_name
  storage_account_access_key    = var.storage_uses_managed_identity ? null : var.storage_account_access_key
  storage_uses_managed_identity = var.storage_uses_managed_identity

  functions_extension_version   = var.functions_extension_version
  builtin_logging_enabled       = var.builtin_logging_enabled
  enabled                       = var.enabled
  https_only                    = var.https_only
  public_network_access_enabled = var.public_network_access_enabled
  client_certificate_enabled    = var.client_certificate_enabled
  client_certificate_mode       = var.client_certificate_mode
  virtual_network_subnet_id     = var.virtual_network_subnet_id

  app_settings = var.app_settings

  site_config {
    always_on                              = var.site_config.always_on
    ftps_state                             = var.site_config.ftps_state
    http2_enabled                          = var.site_config.http2_enabled
    minimum_tls_version                    = var.site_config.minimum_tls_version
    use_32_bit_worker                      = var.site_config.use_32_bit_worker
    vnet_route_all_enabled                 = var.site_config.vnet_route_all_enabled
    application_insights_key               = var.site_config.application_insights_key
    application_insights_connection_string = var.site_config.application_insights_connection_string

    dynamic "application_stack" {
      for_each = var.site_config.application_stack != null ? [var.site_config.application_stack] : []
      content {
        dotnet_version              = application_stack.value.dotnet_version
        java_version                = application_stack.value.java_version
        node_version                = application_stack.value.node_version
        powershell_core_version     = application_stack.value.powershell_core_version
        use_dotnet_isolated_runtime = application_stack.value.use_dotnet_isolated_runtime
      }
    }

    dynamic "cors" {
      for_each = var.site_config.cors != null ? [var.site_config.cors] : []
      content {
        allowed_origins     = cors.value.allowed_origins
        support_credentials = cors.value.support_credentials
      }
    }

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
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.type == "UserAssigned" || identity.value.type == "SystemAssigned, UserAssigned" ? identity.value.identity_ids : null
    }
  }

  dynamic "connection_string" {
    for_each = var.connection_strings
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  tags = local.tags
}
