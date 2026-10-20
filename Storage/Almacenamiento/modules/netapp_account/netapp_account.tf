#############################################################################
# NETAPP ACCOUNT
#############################################################################
resource "azurerm_netapp_account" "netapp_account" {
  name                = var.netapp_account_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  dynamic "active_directory" {
    for_each = var.active_directory != null ? [var.active_directory] : []

    content {
      dns_servers                       = active_directory.value["dns_servers"]
      domain                            = active_directory.value["domain"]
      smb_server_name                   = active_directory.value["smb_server_name"]
      username                          = active_directory.value["username"]
      password                          = active_directory.value["password"]
      aes_encryption_enabled            = try(active_directory.value["aes_encryption_enabled"], null)
      kerberos_ad_name                  = try(active_directory.value["kerberos_ad_name"], null)
      kerberos_kdc_ip                   = try(active_directory.value["kerberos_kdc_ip"], null)
      ldap_over_tls_enabled             = try(active_directory.value["ldap_over_tls_enabled"], null)
      ldap_signing_enabled              = try(active_directory.value["ldap_signing_enabled"], null)
      local_nfs_users_with_ldap_allowed = try(active_directory.value["local_nfs_users_with_ldap_allowed"], null)
      organizational_unit               = try(active_directory.value["organizational_unit"], null)
      server_root_ca_certificate        = try(active_directory.value["server_root_ca_certificate"], null)
      site_name                         = try(active_directory.value["site_name"], null)
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value["type"]
      identity_ids = try(identity.value["identity_ids"], null)
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
