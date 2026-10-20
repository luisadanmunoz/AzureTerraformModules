################################################################################
# Storage Management Policy (Lifecycle Management)
# DEPENDENCY: Storage Account must exist before creating this resource.
################################################################################

resource "azurerm_storage_management_policy" "this" {
  count = var.create ? 1 : 0

  storage_account_id = var.storage_account_id # DEPENDENCY: Storage Account

  dynamic "rule" {
    for_each = var.rules

    content {
      name    = rule.value.name
      enabled = rule.value.enabled

      filters {
        blob_types   = rule.value.filters.blob_types
        prefix_match = length(rule.value.filters.prefix_match) > 0 ? rule.value.filters.prefix_match : null

        dynamic "match_blob_index_tag" {
          for_each = rule.value.filters.match_blob_index_tag

          content {
            name      = match_blob_index_tag.value.name
            operation = match_blob_index_tag.value.operation
            value     = match_blob_index_tag.value.value
          }
        }
      }

      actions {
        dynamic "base_blob" {
          for_each = rule.value.actions.base_blob != null ? [rule.value.actions.base_blob] : []

          content {
            tier_to_cool_after_days_since_modification_greater_than    = base_blob.value.tier_to_cool_after_days
            tier_to_archive_after_days_since_modification_greater_than = base_blob.value.tier_to_archive_after_days
            delete_after_days_since_modification_greater_than          = base_blob.value.delete_after_days
            auto_tier_to_hot_from_cool_enabled                        = base_blob.value.auto_tier_to_hot_from_cool_enabled
          }
        }

        dynamic "snapshot" {
          for_each = rule.value.actions.snapshot != null ? [rule.value.actions.snapshot] : []

          content {
            change_tier_to_cool_after_days_since_creation    = snapshot.value.change_tier_to_cool_after_days
            change_tier_to_archive_after_days_since_creation = snapshot.value.change_tier_to_archive_after_days
            delete_after_days_since_creation_greater_than    = snapshot.value.delete_after_days
          }
        }

        dynamic "version" {
          for_each = rule.value.actions.version != null ? [rule.value.actions.version] : []

          content {
            change_tier_to_cool_after_days_since_creation    = version.value.change_tier_to_cool_after_days
            change_tier_to_archive_after_days_since_creation = version.value.change_tier_to_archive_after_days
            delete_after_days_since_creation_greater_than    = version.value.delete_after_days
          }
        }
      }
    }
  }
}
