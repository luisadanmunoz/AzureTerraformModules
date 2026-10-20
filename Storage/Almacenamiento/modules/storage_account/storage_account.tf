#############################################################################
# STORAGE ACCOUNT
#############################################################################
resource "azurerm_storage_account" "storage_account" {
  name                              = var.storage_account_name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  account_tier                      = var.account_tier
  account_replication_type          = var.account_replication_type
  access_tier                       = var.access_tier
  account_kind                      = var.account_kind
  allow_nested_items_to_be_public   = var.allow_nested_items_to_be_public
  cross_tenant_replication_enabled  = var.cross_tenant_replication_enabled
  default_to_oauth_authentication   = var.default_to_oauth_authentication
  https_traffic_only_enabled        = var.https_traffic_only_enabled
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  is_hns_enabled                    = var.is_hns_enabled
  large_file_share_enabled          = var.large_file_share_enabled
  local_user_enabled                = var.local_user_enabled
  min_tls_version                   = var.min_tls_version
  nfsv3_enabled                     = var.nfsv3_enabled
  public_network_access_enabled     = var.public_network_access_enabled
  sftp_enabled                      = var.sftp_enabled
  shared_access_key_enabled         = var.shared_access_key_enabled
  tags                              = var.tags

  dynamic "blob_properties" {
    for_each = var.blob_properties != null ? [var.blob_properties] : []

    content {
      change_feed_enabled           = try(blob_properties.value["change_feed_enabled"], null)
      change_feed_retention_in_days = try(blob_properties.value["change_feed_retention_in_days"], null)
      last_access_time_enabled      = try(blob_properties.value["last_access_time_enabled"], null)
      versioning_enabled            = try(blob_properties.value["versioning_enabled"], null)

      dynamic "container_delete_retention_policy" {
        for_each = try(blob_properties.value["container_delete_retention_policy"], null) != null ? [blob_properties.value["container_delete_retention_policy"]] : []

        content {
          days = try(container_delete_retention_policy.value["days"], null)
        }
      }

      dynamic "delete_retention_policy" {
        for_each = try(blob_properties.value["delete_retention_policy"], null) != null ? [blob_properties.value["delete_retention_policy"]] : []

        content {
          days                     = try(delete_retention_policy.value["days"], null)
          permanent_delete_enabled = try(delete_retention_policy.value["permanent_delete_enabled"], null)
        }
      }

      dynamic "restore_policy" {
        for_each = try(blob_properties.value["restore_policy"], null) != null ? [blob_properties.value["restore_policy"]] : []

        content {
          days = restore_policy.value["days"]
        }
      }
    }
  }

  dynamic "custom_domain" {
    for_each = var.custom_domain != null ? [var.custom_domain] : []

    content {
      name          = custom_domain.value["name"]
      use_subdomain = try(custom_domain.value["use_subdomain"], null)
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value["type"]
      identity_ids = try(identity.value["identity_ids"], null)
    }
  }

  dynamic "network_rules" {
    for_each = var.network_rules != null ? [var.network_rules] : []

    content {
      default_action             = network_rules.value["default_action"]
      bypass                     = try(network_rules.value["bypass"], null)
      ip_rules                   = try(network_rules.value["ip_rules"], null)
      virtual_network_subnet_ids = try(network_rules.value["virtual_network_subnet_ids"], null)

      dynamic "private_link_access" {
        for_each = try(network_rules.value["private_link_access"], null) != null ? network_rules.value["private_link_access"] : []

        content {
          endpoint_resource_id = private_link_access.value["endpoint_resource_id"]
          endpoint_tenant_id   = try(private_link_access.value["endpoint_tenant_id"], null)
        }
      }
    }
  }

  dynamic "queue_properties" {
    for_each = var.queue_properties != null ? [var.queue_properties] : []

    content {
      dynamic "cors_rule" {
        for_each = try(queue_properties.value["cors_rules"], null) != null ? queue_properties.value["cors_rules"] : []

        content {
          allowed_headers    = cors_rule.value["allowed_headers"]
          allowed_methods    = cors_rule.value["allowed_methods"]
          allowed_origins    = cors_rule.value["allowed_origins"]
          exposed_headers    = cors_rule.value["exposed_headers"]
          max_age_in_seconds = cors_rule.value["max_age_in_seconds"]
        }
      }

      dynamic "logging" {
        for_each = try(queue_properties.value["logging"], null) != null ? [queue_properties.value["logging"]] : []

        content {
          delete                = logging.value["delete"]
          read                  = logging.value["read"]
          retention_policy_days = try(logging.value["retention_policy_days"], null)
          version               = logging.value["version"]
          write                 = logging.value["write"]
        }
      }

      dynamic "hour_metrics" {
        for_each = try(queue_properties.value["hour_metrics"], null) != null ? [queue_properties.value["hour_metrics"]] : []

        content {
          enabled               = hour_metrics.value["enabled"]
          include_apis          = try(hour_metrics.value["include_apis"], null)
          retention_policy_days = try(hour_metrics.value["retention_policy_days"], null)
          version               = hour_metrics.value["version"]
        }
      }

      dynamic "minute_metrics" {
        for_each = try(queue_properties.value["minute_metrics"], null) != null ? [queue_properties.value["minute_metrics"]] : []

        content {
          enabled               = minute_metrics.value["enabled"]
          include_apis          = try(minute_metrics.value["include_apis"], null)
          retention_policy_days = try(minute_metrics.value["retention_policy_days"], null)
          version               = minute_metrics.value["version"]
        }
      }
    }
  }

  dynamic "routing" {
    for_each = var.routing != null ? [var.routing] : []

    content {
      choice                      = try(routing.value["choice"], null)
      publish_internet_endpoints  = try(routing.value["publish_internet_endpoints"], null)
      publish_microsoft_endpoints = try(routing.value["publish_microsoft_endpoints"], null)
    }
  }

  dynamic "sas_policy" {
    for_each = var.sas_policy != null ? [var.sas_policy] : []

    content {
      expiration_period = sas_policy.value["expiration_period"]
      expiration_action = try(sas_policy.value["expiration_action"], null)
    }
  }

  dynamic "share_properties" {
    for_each = var.share_properties != null ? [var.share_properties] : []

    content {
      dynamic "cors_rule" {
        for_each = try(share_properties.value["cors_rules"], null) != null ? share_properties.value["cors_rules"] : []

        content {
          allowed_headers    = cors_rule.value["allowed_headers"]
          allowed_methods    = cors_rule.value["allowed_methods"]
          allowed_origins    = cors_rule.value["allowed_origins"]
          exposed_headers    = cors_rule.value["exposed_headers"]
          max_age_in_seconds = cors_rule.value["max_age_in_seconds"]
        }
      }

      dynamic "retention_policy" {
        for_each = try(share_properties.value["retention_policy"], null) != null ? [share_properties.value["retention_policy"]] : []

        content {
          days = try(retention_policy.value["days"], null)
        }
      }

      dynamic "smb" {
        for_each = try(share_properties.value["smb"], null) != null ? [share_properties.value["smb"]] : []

        content {
          authentication_types            = try(smb.value["authentication_types"], null)
          channel_encryption_type         = try(smb.value["channel_encryption_type"], null)
          kerberos_ticket_encryption_type = try(smb.value["kerberos_ticket_encryption_type"], null)
          multichannel_enabled            = try(smb.value["multichannel_enabled"], null)
          versions                        = try(smb.value["versions"], null)
        }
      }
    }
  }

  dynamic "static_website" {
    for_each = var.static_website != null ? [var.static_website] : []

    content {
      index_document     = try(static_website.value["index_document"], null)
      error_404_document = try(static_website.value["error_404_document"], null)
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      update = try(timeouts.value["update"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }
}
