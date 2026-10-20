#############################################################################
# NETAPP VOLUME
#############################################################################
resource "azurerm_netapp_volume" "netapp_volume" {
  name                                                 = var.netapp_volume_name
  account_name                                         = var.account_name
  pool_name                                            = var.pool_name
  resource_group_name                                  = var.resource_group_name
  location                                             = var.location
  service_level                                        = var.service_level
  storage_quota_in_gb                                  = var.storage_quota_in_gb
  subnet_id                                            = var.subnet_id
  volume_path                                          = var.volume_path
  accept_grow_capacity_pool_for_short_term_clone_split = var.accept_grow_capacity_pool_for_short_term_clone_split
  azure_vmware_data_store_enabled                      = var.azure_vmware_data_store_enabled
  create_from_snapshot_resource_id                     = var.create_from_snapshot_resource_id
  kerberos_enabled                                     = var.kerberos_enabled
  large_volume_enabled                                 = var.large_volume_enabled
  network_features                                     = var.network_features
  protocols                                            = var.protocols
  security_style                                       = var.security_style
  smb3_protocol_encryption_enabled                     = var.smb3_protocol_encryption_enabled
  smb_access_based_enumeration_enabled                 = var.smb_access_based_enumeration_enabled
  smb_continuous_availability_enabled                  = var.smb_continuous_availability_enabled
  smb_non_browsable_enabled                            = var.smb_non_browsable_enabled
  snapshot_directory_visible                           = var.snapshot_directory_visible
  throughput_in_mibps                                  = var.throughput_in_mibps
  zone                                                 = var.zone
  tags                                                 = var.tags

  dynamic "cool_access" {
    for_each = var.cool_access != null ? [var.cool_access] : []

    content {
      coolness_period_in_days = cool_access.value["coolness_period_in_days"]
      retrieval_policy        = cool_access.value["retrieval_policy"]
      tiering_policy          = cool_access.value["tiering_policy"]
    }
  }

  dynamic "data_protection_advanced_ransomware" {
    for_each = var.data_protection_advanced_ransomware != null ? [var.data_protection_advanced_ransomware] : []

    content {
      protection_enabled = data_protection_advanced_ransomware.value["protection_enabled"]
    }
  }

  dynamic "data_protection_backup_policy" {
    for_each = var.data_protection_backup_policy != null ? [var.data_protection_backup_policy] : []

    content {
      backup_policy_id = data_protection_backup_policy.value["backup_policy_id"]
      backup_vault_id  = data_protection_backup_policy.value["backup_vault_id"]
      policy_enabled   = try(data_protection_backup_policy.value["policy_enabled"], null)
    }
  }

  dynamic "data_protection_replication" {
    for_each = var.data_protection_replication != null ? [var.data_protection_replication] : []

    content {
      remote_volume_location    = data_protection_replication.value["remote_volume_location"]
      remote_volume_resource_id = data_protection_replication.value["remote_volume_resource_id"]
      replication_frequency     = data_protection_replication.value["replication_frequency"]
      endpoint_type             = try(data_protection_replication.value["endpoint_type"], null)
    }
  }

  dynamic "data_protection_snapshot_policy" {
    for_each = var.snapshot_policy_id != null ? [{ snapshot_policy_id = var.snapshot_policy_id }] : []

    content {
      snapshot_policy_id = data_protection_snapshot_policy.value["snapshot_policy_id"]
    }
  }

  dynamic "export_policy_rule" {
    for_each = var.export_policy_rules != null ? var.export_policy_rules : []

    content {
      allowed_clients                = export_policy_rule.value["allowed_clients"]
      rule_index                     = export_policy_rule.value["rule_index"]
      kerberos_5_read_only_enabled   = try(export_policy_rule.value["kerberos_5_read_only_enabled"], null)
      kerberos_5_read_write_enabled  = try(export_policy_rule.value["kerberos_5_read_write_enabled"], null)
      kerberos_5i_read_only_enabled  = try(export_policy_rule.value["kerberos_5i_read_only_enabled"], null)
      kerberos_5i_read_write_enabled = try(export_policy_rule.value["kerberos_5i_read_write_enabled"], null)
      kerberos_5p_read_only_enabled  = try(export_policy_rule.value["kerberos_5p_read_only_enabled"], null)
      kerberos_5p_read_write_enabled = try(export_policy_rule.value["kerberos_5p_read_write_enabled"], null)
      protocol                       = try(export_policy_rule.value["protocol"], null)
      protocols_enabled              = try(export_policy_rule.value["protocols_enabled"], null)
      root_access_enabled            = try(export_policy_rule.value["root_access_enabled"], null)
      unix_read_only                 = try(export_policy_rule.value["unix_read_only"], null)
      unix_read_write                = try(export_policy_rule.value["unix_read_write"], null)
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
