#############################################################################
# STORAGE ACCOUNTS
#############################################################################
module "storage_account" {
  source = "./modules/storage_account"

  for_each = var.storage_accounts

  storage_account_name = each.value["storage_account_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                          = each.value["location"]
  account_tier                      = each.value["account_tier"]
  account_replication_type          = each.value["account_replication_type"]
  access_tier                       = try(each.value["access_tier"], null)
  account_kind                      = try(each.value["account_kind"], null)
  allow_nested_items_to_be_public   = try(each.value["allow_nested_items_to_be_public"], null)
  cross_tenant_replication_enabled  = try(each.value["cross_tenant_replication_enabled"], null)
  default_to_oauth_authentication   = try(each.value["default_to_oauth_authentication"], null)
  https_traffic_only_enabled        = try(each.value["https_traffic_only_enabled"], null)
  infrastructure_encryption_enabled = try(each.value["infrastructure_encryption_enabled"], null)
  is_hns_enabled                    = try(each.value["is_hns_enabled"], null)
  large_file_share_enabled          = try(each.value["large_file_share_enabled"], null)
  local_user_enabled                = try(each.value["local_user_enabled"], null)
  min_tls_version                   = try(each.value["min_tls_version"], null)
  nfsv3_enabled                     = try(each.value["nfsv3_enabled"], null)
  public_network_access_enabled     = try(each.value["public_network_access_enabled"], null)
  sftp_enabled                      = try(each.value["sftp_enabled"], null)
  shared_access_key_enabled         = try(each.value["shared_access_key_enabled"], null)
  blob_properties                   = try(each.value["blob_properties"], null)
  custom_domain                     = try(each.value["custom_domain"], null)
  identity                          = try(each.value["identity"], null)
  network_rules                     = try(each.value["network_rules"], null)
  queue_properties                  = try(each.value["queue_properties"], null)
  routing                           = try(each.value["routing"], null)
  sas_policy                        = try(each.value["sas_policy"], null)
  share_properties                  = try(each.value["share_properties"], null)
  static_website                    = try(each.value["static_website"], null)
  timeouts                          = try(each.value["timeouts"], null)
  tags                              = try(each.value["tags"], var.tags)
}
