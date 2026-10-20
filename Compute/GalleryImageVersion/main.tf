################################################################################
# Gallery Image Version
################################################################################

# DEPENDENCY: Resource Group must exist
# DEPENDENCY: Shared Image Gallery must exist
# DEPENDENCY: Gallery Image Definition must exist

resource "azurerm_shared_image_version" "this" {
  count = var.create ? 1 : 0

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  gallery_name        = var.gallery_name
  image_name          = var.image_name

  managed_image_id    = var.managed_image_id
  blob_uri            = var.blob_uri
  storage_account_id  = var.storage_account_id
  exclude_from_latest = var.exclude_from_latest
  end_of_life_date    = var.end_of_life_date
  replication_mode    = var.replication_mode

  dynamic "target_region" {
    for_each = var.target_regions
    content {
      name                        = target_region.value.name
      regional_replica_count      = target_region.value.regional_replica_count
      storage_account_type        = target_region.value.storage_account_type
      disk_encryption_set_id      = target_region.value.disk_encryption_set_id
      exclude_from_latest_enabled = target_region.value.exclude_from_latest_enabled
    }
  }

  tags = local.tags
}
