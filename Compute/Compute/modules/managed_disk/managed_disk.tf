#############################################################################
# MANAGED DISK
#############################################################################
resource "azurerm_managed_disk" "managed_disk" {
  name                              = var.managed_disk_name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  create_option                     = var.create_option
  storage_account_type              = var.storage_account_type
  disk_access_id                    = var.disk_access_id
  disk_encryption_set_id            = var.disk_encryption_set_id
  disk_iops_read_only               = var.disk_iops_read_only
  disk_iops_read_write              = var.disk_iops_read_write
  disk_mbps_read_only               = var.disk_mbps_read_only
  disk_mbps_read_write              = var.disk_mbps_read_write
  disk_size_gb                      = var.disk_size_gb
  edge_zone                         = var.edge_zone
  gallery_image_reference_id        = var.gallery_image_reference_id
  hyper_v_generation                = var.hyper_v_generation
  image_reference_id                = var.image_reference_id
  logical_sector_size               = var.logical_sector_size
  max_shares                        = var.max_shares
  network_access_policy             = var.network_access_policy
  on_demand_bursting_enabled        = var.on_demand_bursting_enabled
  optimized_frequent_attach_enabled = var.optimized_frequent_attach_enabled
  os_type                           = var.os_type
  performance_plus_enabled          = var.performance_plus_enabled
  public_network_access_enabled     = var.public_network_access_enabled
  secure_vm_disk_encryption_set_id  = var.secure_vm_disk_encryption_set_id
  security_type                     = var.security_type
  source_resource_id                = var.source_resource_id
  source_uri                        = var.source_uri
  storage_account_id                = var.storage_account_id
  trusted_launch_enabled            = var.trusted_launch_enabled
  upload_size_bytes                 = var.upload_size_bytes
  zone                              = var.zone
  tags                              = var.tags

  dynamic "encryption_settings" {
    for_each = var.encryption_settings != null ? [var.encryption_settings] : []

    content {
      dynamic "disk_encryption_key" {
        for_each = [encryption_settings.value["disk_encryption_key"]]

        content {
          secret_url      = disk_encryption_key.value["secret_url"]
          source_vault_id = disk_encryption_key.value["source_vault_id"]
        }
      }

      dynamic "key_encryption_key" {
        for_each = try(encryption_settings.value["key_encryption_key"], null) != null ? [encryption_settings.value["key_encryption_key"]] : []

        content {
          key_url         = key_encryption_key.value["key_url"]
          source_vault_id = key_encryption_key.value["source_vault_id"]
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
