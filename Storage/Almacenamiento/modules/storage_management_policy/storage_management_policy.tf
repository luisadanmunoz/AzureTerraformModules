#############################################################################
# STORAGE MANAGEMENT POLICY
#############################################################################
resource "azurerm_storage_management_policy" "storage_management_policy" {
  storage_account_id = var.storage_account_id

  dynamic "rule" {
    for_each = var.rules

    content {
      name    = rule.value["name"]
      enabled = rule.value["enabled"]

      filters {
        blob_types   = rule.value["filters"]["blob_types"]
        prefix_match = try(rule.value["filters"]["prefix_match"], null)
      }

      actions {
        dynamic "base_blob" {
          for_each = try(rule.value["actions"]["base_blob"], null) != null ? [rule.value["actions"]["base_blob"]] : []

          content {
            auto_tier_to_hot_from_cool_enabled                             = try(base_blob.value["auto_tier_to_hot_from_cool_enabled"], null)
            delete_after_days_since_creation_greater_than                  = try(base_blob.value["delete_after_days_since_creation_greater_than"], null)
            delete_after_days_since_last_access_time_greater_than          = try(base_blob.value["delete_after_days_since_last_access_time_greater_than"], null)
            delete_after_days_since_modification_greater_than              = try(base_blob.value["delete_after_days_since_modification_greater_than"], null)
            tier_to_archive_after_days_since_creation_greater_than         = try(base_blob.value["tier_to_archive_after_days_since_creation_greater_than"], null)
            tier_to_archive_after_days_since_last_access_time_greater_than = try(base_blob.value["tier_to_archive_after_days_since_last_access_time_greater_than"], null)
            tier_to_archive_after_days_since_last_tier_change_greater_than = try(base_blob.value["tier_to_archive_after_days_since_last_tier_change_greater_than"], null)
            tier_to_archive_after_days_since_modification_greater_than     = try(base_blob.value["tier_to_archive_after_days_since_modification_greater_than"], null)
            tier_to_cold_after_days_since_creation_greater_than            = try(base_blob.value["tier_to_cold_after_days_since_creation_greater_than"], null)
            tier_to_cold_after_days_since_last_access_time_greater_than    = try(base_blob.value["tier_to_cold_after_days_since_last_access_time_greater_than"], null)
            tier_to_cold_after_days_since_modification_greater_than        = try(base_blob.value["tier_to_cold_after_days_since_modification_greater_than"], null)
            tier_to_cool_after_days_since_creation_greater_than            = try(base_blob.value["tier_to_cool_after_days_since_creation_greater_than"], null)
            tier_to_cool_after_days_since_last_access_time_greater_than    = try(base_blob.value["tier_to_cool_after_days_since_last_access_time_greater_than"], null)
            tier_to_cool_after_days_since_modification_greater_than        = try(base_blob.value["tier_to_cool_after_days_since_modification_greater_than"], null)
          }
        }

        dynamic "snapshot" {
          for_each = try(rule.value["actions"]["snapshot"], null) != null ? [rule.value["actions"]["snapshot"]] : []

          content {
            change_tier_to_archive_after_days_since_creation               = try(snapshot.value["change_tier_to_archive_after_days_since_creation"], null)
            change_tier_to_cool_after_days_since_creation                  = try(snapshot.value["change_tier_to_cool_after_days_since_creation"], null)
            delete_after_days_since_creation_greater_than                  = try(snapshot.value["delete_after_days_since_creation_greater_than"], null)
            tier_to_archive_after_days_since_last_tier_change_greater_than = try(snapshot.value["tier_to_archive_after_days_since_last_tier_change_greater_than"], null)
            tier_to_cold_after_days_since_creation_greater_than            = try(snapshot.value["tier_to_cold_after_days_since_creation_greater_than"], null)
          }
        }

        dynamic "version" {
          for_each = try(rule.value["actions"]["version"], null) != null ? [rule.value["actions"]["version"]] : []

          content {
            change_tier_to_archive_after_days_since_creation               = try(version.value["change_tier_to_archive_after_days_since_creation"], null)
            change_tier_to_cool_after_days_since_creation                  = try(version.value["change_tier_to_cool_after_days_since_creation"], null)
            delete_after_days_since_creation                               = try(version.value["delete_after_days_since_creation"], null)
            tier_to_archive_after_days_since_last_tier_change_greater_than = try(version.value["tier_to_archive_after_days_since_last_tier_change_greater_than"], null)
            tier_to_cold_after_days_since_creation_greater_than            = try(version.value["tier_to_cold_after_days_since_creation_greater_than"], null)
          }
        }
      }
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
