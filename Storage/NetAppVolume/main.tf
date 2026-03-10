# -----------------------------------------------------------------------------
# Azure NetApp Files Volume
# -----------------------------------------------------------------------------
# This module creates an Azure NetApp Files Volume within a NetApp Pool.
# The volume can be used for NFS, SMB, or dual-protocol file shares.
# -----------------------------------------------------------------------------

resource "azurerm_netapp_volume" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  location            = var.location
  resource_group_name = var.resource_group_name
  account_name        = var.account_name
  pool_name           = var.pool_name
  volume_path         = var.volume_path
  service_level       = var.service_level
  subnet_id           = var.subnet_id
  storage_quota_in_gb = var.storage_quota_in_gb
  protocols           = var.protocols

  security_style             = var.security_style
  snapshot_directory_visible = var.snapshot_directory_visible
  throughput_in_mibps        = var.throughput_in_mibps
  network_features           = var.network_features

  azure_vmware_data_store_enabled = var.azure_vmware_data_store_enabled

  # Dynamic export policy rules for NFS volumes
  dynamic "export_policy_rule" {
    for_each = var.export_policy_rules != null ? var.export_policy_rules : []

    content {
      rule_index                     = export_policy_rule.value.rule_index
      allowed_clients                = export_policy_rule.value.allowed_clients
      protocols_enabled              = export_policy_rule.value.protocols_enabled
      unix_read_only                 = export_policy_rule.value.unix_read_only
      unix_read_write                = export_policy_rule.value.unix_read_write
      root_access_enabled            = export_policy_rule.value.root_access_enabled
      kerberos_5_read_only_enabled   = export_policy_rule.value.kerberos_5_read_only_enabled
      kerberos_5_read_write_enabled  = export_policy_rule.value.kerberos_5_read_write_enabled
      kerberos_5i_read_only_enabled  = export_policy_rule.value.kerberos_5i_read_only_enabled
      kerberos_5i_read_write_enabled = export_policy_rule.value.kerberos_5i_read_write_enabled
      kerberos_5p_read_only_enabled  = export_policy_rule.value.kerberos_5p_read_only_enabled
      kerberos_5p_read_write_enabled = export_policy_rule.value.kerberos_5p_read_write_enabled
    }
  }

  # Dynamic data protection for cross-region replication
  dynamic "data_protection_replication" {
    for_each = var.data_protection_replication != null ? [var.data_protection_replication] : []

    content {
      endpoint_type             = data_protection_replication.value.endpoint_type
      remote_volume_location    = data_protection_replication.value.remote_volume_location
      remote_volume_resource_id = data_protection_replication.value.remote_volume_resource_id
      replication_frequency     = data_protection_replication.value.replication_frequency
    }
  }

  # Dynamic data protection for snapshot policies
  dynamic "data_protection_snapshot_policy" {
    for_each = var.data_protection_snapshot_policy != null ? [var.data_protection_snapshot_policy] : []

    content {
      snapshot_policy_id = data_protection_snapshot_policy.value.snapshot_policy_id
    }
  }

  tags = local.tags
}
