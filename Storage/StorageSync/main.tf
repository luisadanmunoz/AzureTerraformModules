################################################################################
# Storage Sync Service
################################################################################

# DEPENDENCY: Resource Group must exist before creating this resource
resource "azurerm_storage_sync" "this" {
  count = var.create ? 1 : 0

  name                    = local.resource_name
  resource_group_name     = var.resource_group_name # DEPENDENCY: Resource Group
  location                = var.location            # DEPENDENCY: Should align with Resource Group location
  incoming_traffic_policy = var.incoming_traffic_policy

  tags = local.tags
}

################################################################################
# Storage Sync Groups
################################################################################

# DEPENDENCY: Storage Sync Service must exist before creating Sync Groups
resource "azurerm_storage_sync_group" "this" {
  for_each = var.create ? var.sync_groups : {}

  name            = each.value.name
  storage_sync_id = azurerm_storage_sync.this[0].id # DEPENDENCY: Storage Sync Service
}

################################################################################
# Storage Sync Cloud Endpoints
################################################################################

# DEPENDENCY: Storage Sync Group, Storage Account, and File Share must exist
resource "azurerm_storage_sync_cloud_endpoint" "this" {
  for_each = var.create ? var.cloud_endpoints : {}

  name                      = "${each.value.sync_group_key}-${each.value.file_share_name}"
  storage_sync_group_id     = azurerm_storage_sync_group.this[each.value.sync_group_key].id # DEPENDENCY: Sync Group
  file_share_name           = each.value.file_share_name                                    # DEPENDENCY: File Share
  storage_account_id        = each.value.storage_account_id                                 # DEPENDENCY: Storage Account
  storage_account_tenant_id = each.value.storage_account_tenant_id
}
