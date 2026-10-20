#############################################################################
# NETAPP VOLUMES
#############################################################################
module "netapp_volume" {
  source = "./modules/netapp_volume"

  for_each = var.netapp_volumes

  netapp_volume_name = each.value["netapp_volume_name"]
  account_name = try(
    element([for _, netapp_account in module.netapp_account : netapp_account.name if netapp_account.name == each.value["netapp_account_name"]], 0),
    each.value["netapp_account_name"]
  )
  pool_name = try(
    element([for _, netapp_pool in module.netapp_pool : netapp_pool.name if netapp_pool.name == each.value["netapp_pool_name"]], 0),
    each.value["netapp_pool_name"]
  )
  snapshot_policy_id = try(
    element([for _, netapp_snapshot_policy in module.netapp_snapshot_policy : netapp_snapshot_policy.id if netapp_snapshot_policy.name == each.value["netapp_snapshot_policy_name"]], 0),
    each.value["snapshot_policy_id"],
    null
  )
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                                             = each.value["location"]
  service_level                                        = each.value["service_level"]
  storage_quota_in_gb                                  = each.value["storage_quota_in_gb"]
  subnet_id                                            = each.value["subnet_id"]
  volume_path                                          = each.value["volume_path"]
  accept_grow_capacity_pool_for_short_term_clone_split = try(each.value["accept_grow_capacity_pool_for_short_term_clone_split"], null)
  azure_vmware_data_store_enabled                      = try(each.value["azure_vmware_data_store_enabled"], null)
  create_from_snapshot_resource_id                     = try(each.value["create_from_snapshot_resource_id"], null)
  kerberos_enabled                                     = try(each.value["kerberos_enabled"], null)
  large_volume_enabled                                 = try(each.value["large_volume_enabled"], null)
  network_features                                     = try(each.value["network_features"], null)
  protocols                                            = try(each.value["protocols"], null)
  security_style                                       = try(each.value["security_style"], null)
  smb3_protocol_encryption_enabled                     = try(each.value["smb3_protocol_encryption_enabled"], null)
  smb_access_based_enumeration_enabled                 = try(each.value["smb_access_based_enumeration_enabled"], null)
  smb_continuous_availability_enabled                  = try(each.value["smb_continuous_availability_enabled"], null)
  smb_non_browsable_enabled                            = try(each.value["smb_non_browsable_enabled"], null)
  snapshot_directory_visible                           = try(each.value["snapshot_directory_visible"], null)
  throughput_in_mibps                                  = try(each.value["throughput_in_mibps"], null)
  zone                                                 = try(each.value["zone"], null)
  cool_access                                          = try(each.value["cool_access"], null)
  data_protection_advanced_ransomware                  = try(each.value["data_protection_advanced_ransomware"], null)
  data_protection_backup_policy                        = try(each.value["data_protection_backup_policy"], null)
  data_protection_replication                          = try(each.value["data_protection_replication"], null)
  export_policy_rules                                  = try(each.value["export_policy_rules"], [])
  timeouts                                             = try(each.value["timeouts"], null)
  tags                                                 = try(each.value["tags"], var.tags)
}
