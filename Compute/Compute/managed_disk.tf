#############################################################################
# MANAGED DISKS
#############################################################################
module "managed_disk" {
  source = "./modules/managed_disk"

  for_each = var.managed_disks

  managed_disk_name = each.value["managed_disk_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                          = each.value["location"]
  create_option                     = each.value["create_option"]
  storage_account_type              = each.value["storage_account_type"]
  disk_access_id                    = try(each.value["disk_access_id"], null)
  disk_encryption_set_id            = try(each.value["disk_encryption_set_id"], null)
  disk_iops_read_only               = try(each.value["disk_iops_read_only"], null)
  disk_iops_read_write              = try(each.value["disk_iops_read_write"], null)
  disk_mbps_read_only               = try(each.value["disk_mbps_read_only"], null)
  disk_mbps_read_write              = try(each.value["disk_mbps_read_write"], null)
  disk_size_gb                      = try(each.value["disk_size_gb"], null)
  edge_zone                         = try(each.value["edge_zone"], null)
  gallery_image_reference_id        = try(each.value["gallery_image_reference_id"], null)
  hyper_v_generation                = try(each.value["hyper_v_generation"], null)
  image_reference_id                = try(each.value["image_reference_id"], null)
  logical_sector_size               = try(each.value["logical_sector_size"], null)
  max_shares                        = try(each.value["max_shares"], null)
  network_access_policy             = try(each.value["network_access_policy"], null)
  on_demand_bursting_enabled        = try(each.value["on_demand_bursting_enabled"], null)
  optimized_frequent_attach_enabled = try(each.value["optimized_frequent_attach_enabled"], null)
  os_type                           = try(each.value["os_type"], null)
  performance_plus_enabled          = try(each.value["performance_plus_enabled"], null)
  public_network_access_enabled     = try(each.value["public_network_access_enabled"], null)
  secure_vm_disk_encryption_set_id  = try(each.value["secure_vm_disk_encryption_set_id"], null)
  security_type                     = try(each.value["security_type"], null)
  source_resource_id                = try(each.value["source_resource_id"], null)
  source_uri                        = try(each.value["source_uri"], null)
  storage_account_id                = try(each.value["storage_account_id"], null)
  trusted_launch_enabled            = try(each.value["trusted_launch_enabled"], null)
  upload_size_bytes                 = try(each.value["upload_size_bytes"], null)
  zone                              = try(each.value["zone"], null)
  encryption_settings               = try(each.value["encryption_settings"], null)
  timeouts                          = try(each.value["timeouts"], null)
  tags                              = try(each.value["tags"], var.tags)
}
