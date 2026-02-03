################################################################################
# Data Lake Storage Gen2 Filesystem
################################################################################

# DEPENDENCY: Storage Account with is_hns_enabled=true must exist before creating this resource
resource "azurerm_storage_data_lake_gen2_filesystem" "this" {
  count = var.create ? 1 : 0

  name               = local.resource_name
  storage_account_id = var.storage_account_id # DEPENDENCY: Storage Account (HNS-enabled)

  properties = length(var.properties) > 0 ? var.properties : null
  owner      = var.owner # DEPENDENCY: AAD object ID (optional)
  group      = var.group # DEPENDENCY: AAD object ID (optional)

  # ACL configuration
  dynamic "ace" {
    for_each = var.ace

    content {
      scope       = ace.value.scope
      type        = ace.value.type
      id          = ace.value.id          # DEPENDENCY: AAD object ID for user/group types
      permissions = ace.value.permissions
    }
  }
}

################################################################################
# Data Lake Storage Gen2 Paths (Directories)
################################################################################

# DEPENDENCY: Data Lake Gen2 Filesystem must be created before paths
resource "azurerm_storage_data_lake_gen2_path" "this" {
  for_each = var.create ? var.paths : {}

  path               = each.value.path
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.this[0].name # DEPENDENCY: Filesystem
  storage_account_id = var.storage_account_id                                 # DEPENDENCY: Storage Account (HNS-enabled)
  resource           = each.value.resource

  owner = each.value.owner # DEPENDENCY: AAD object ID (optional)
  group = each.value.group # DEPENDENCY: AAD object ID (optional)

  # ACL configuration for the path
  dynamic "ace" {
    for_each = each.value.ace

    content {
      scope       = ace.value.scope
      type        = ace.value.type
      id          = ace.value.id          # DEPENDENCY: AAD object ID for user/group types
      permissions = ace.value.permissions
    }
  }
}
