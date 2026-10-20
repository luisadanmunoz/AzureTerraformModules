################################################################################
# Storage Account
################################################################################

# DEPENDENCY: Resource Group must exist before creating this resource
resource "azurerm_storage_account" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name # DEPENDENCY: Resource Group
  location            = var.location            # DEPENDENCY: Should align with Resource Group location

  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind
  access_tier              = var.access_tier

  min_tls_version                  = var.min_tls_version
  enable_https_traffic_only        = var.enable_https_traffic_only
  allow_nested_items_to_be_public  = var.allow_nested_items_to_be_public
  shared_access_key_enabled        = var.shared_access_key_enabled
  is_hns_enabled                   = var.is_hns_enabled
  nfsv3_enabled                    = var.nfsv3_enabled
  large_file_share_enabled         = var.large_file_share_enabled
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  public_network_access_enabled    = var.public_network_access_enabled
  default_to_oauth_authentication  = var.default_to_oauth_authentication
  cross_tenant_replication_enabled  = var.cross_tenant_replication_enabled

  ############################################################################
  # Network Rules
  ############################################################################

  dynamic "network_rules" {
    for_each = var.network_rules != null ? [var.network_rules] : []

    content {
      default_action             = network_rules.value.default_action
      bypass                     = network_rules.value.bypass
      ip_rules                   = network_rules.value.ip_rules
      virtual_network_subnet_ids = network_rules.value.virtual_network_subnet_ids # DEPENDENCY: Subnet IDs

      dynamic "private_link_access" {
        for_each = network_rules.value.private_link_access != null ? network_rules.value.private_link_access : []

        content {
          endpoint_resource_id = private_link_access.value.endpoint_resource_id # DEPENDENCY: Private Link resource
          endpoint_tenant_id   = private_link_access.value.endpoint_tenant_id
        }
      }
    }
  }

  ############################################################################
  # Blob Properties
  ############################################################################

  dynamic "blob_properties" {
    for_each = var.blob_properties != null ? [var.blob_properties] : []

    content {
      versioning_enabled            = blob_properties.value.versioning_enabled
      change_feed_enabled           = blob_properties.value.change_feed_enabled
      change_feed_retention_in_days = blob_properties.value.change_feed_retention_in_days
      last_access_time_enabled      = blob_properties.value.last_access_time_enabled

      dynamic "delete_retention_policy" {
        for_each = blob_properties.value.delete_retention_policy != null ? [blob_properties.value.delete_retention_policy] : []

        content {
          days = delete_retention_policy.value.days
        }
      }

      dynamic "container_delete_retention_policy" {
        for_each = blob_properties.value.container_delete_retention_policy != null ? [blob_properties.value.container_delete_retention_policy] : []

        content {
          days = container_delete_retention_policy.value.days
        }
      }

      dynamic "cors_rule" {
        for_each = blob_properties.value.cors_rule != null ? blob_properties.value.cors_rule : []

        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }
    }
  }

  ############################################################################
  # Identity
  ############################################################################

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value.type
      identity_ids = length(identity.value.identity_ids) > 0 ? identity.value.identity_ids : null # DEPENDENCY: User Assigned Identity
    }
  }

  ############################################################################
  # Customer Managed Key
  ############################################################################

  dynamic "customer_managed_key" {
    for_each = var.customer_managed_key != null ? [var.customer_managed_key] : []

    content {
      key_vault_key_id          = customer_managed_key.value.key_vault_key_id          # DEPENDENCY: Key Vault Key
      user_assigned_identity_id = customer_managed_key.value.user_assigned_identity_id # DEPENDENCY: User Assigned Identity
    }
  }

  ############################################################################
  # Immutability Policy
  ############################################################################

  dynamic "immutability_policy" {
    for_each = var.immutability_policy != null ? [var.immutability_policy] : []

    content {
      allow_protected_append_writes = immutability_policy.value.allow_protected_append_writes
      period_since_creation_in_days = immutability_policy.value.period_since_creation_in_days
      state                         = immutability_policy.value.state
    }
  }

  ############################################################################
  # Static Website
  ############################################################################

  dynamic "static_website" {
    for_each = var.static_website != null ? [var.static_website] : []

    content {
      index_document     = static_website.value.index_document
      error_404_document = static_website.value.error_404_document
    }
  }

  ############################################################################
  # Custom Domain
  ############################################################################

  dynamic "custom_domain" {
    for_each = var.custom_domain != null ? [var.custom_domain] : []

    content {
      name          = custom_domain.value.name
      use_subdomain = custom_domain.value.use_subdomain
    }
  }

  tags = local.tags
}

################################################################################
# Diagnostic Settings (Optional)
################################################################################

# DEPENDENCY: Log Analytics Workspace, Storage Account, or Event Hub must exist
resource "azurerm_monitor_diagnostic_setting" "this" {
  count = local.create_diagnostic_settings ? 1 : 0

  name                           = var.diagnostic_settings.name
  target_resource_id             = azurerm_storage_account.this[0].id
  log_analytics_workspace_id     = var.diagnostic_settings.log_analytics_workspace_id     # DEPENDENCY: Log Analytics Workspace
  storage_account_id             = var.diagnostic_settings.storage_account_id             # DEPENDENCY: Storage Account
  eventhub_authorization_rule_id = var.diagnostic_settings.eventhub_authorization_rule_id # DEPENDENCY: Event Hub
  eventhub_name                  = var.diagnostic_settings.eventhub_name

  dynamic "metric" {
    for_each = var.diagnostic_settings.metric_categories

    content {
      category = metric.value
      enabled  = true
    }
  }
}
