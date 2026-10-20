# -----------------------------------------------------------------------------
# Azure NetApp Files Account
# -----------------------------------------------------------------------------
# This module creates an Azure NetApp Files Account, which is a logical container
# for NetApp capacity pools and volumes. The account can optionally be joined to
# an Active Directory domain for SMB volume support.
# -----------------------------------------------------------------------------

resource "azurerm_netapp_account" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = local.tags

  dynamic "active_directory" {
    for_each = var.active_directory != null ? [var.active_directory] : []

    content {
      dns_servers                       = active_directory.value.dns_servers
      domain                            = active_directory.value.domain
      username                          = active_directory.value.username
      password                          = active_directory.value.password
      smb_server_name                   = active_directory.value.smb_server_name
      organizational_unit               = active_directory.value.organizational_unit
      kerberos_ad_name                  = active_directory.value.kerberos_ad_name
      kerberos_kdc_ip                   = active_directory.value.kerberos_kdc_ip
      aes_encryption_enabled            = active_directory.value.aes_encryption_enabled
      local_nfs_users_with_ldap_allowed = active_directory.value.local_nfs_users_with_ldap_allowed
      ldap_over_tls_enabled             = active_directory.value.ldap_over_tls_enabled
      server_root_ca_certificate        = active_directory.value.server_root_ca_certificate
      ldap_signing_enabled              = active_directory.value.ldap_signing_enabled
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }
}
