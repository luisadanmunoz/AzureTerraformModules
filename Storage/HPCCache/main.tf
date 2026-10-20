# -----------------------------------------------------------------------------
# AZURE HPC CACHE
# -----------------------------------------------------------------------------

resource "azurerm_hpc_cache" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location
  cache_size_in_gb    = var.cache_size_in_gb
  sku_name            = var.sku_name
  subnet_id           = var.subnet_id
  mtu                 = var.mtu
  ntp_server          = var.ntp_server

  # Customer-managed key encryption
  key_vault_key_id                           = var.key_vault_key_id
  automatically_rotate_key_to_latest_enabled = var.key_vault_key_id != null ? var.automatically_rotate_key_to_latest_enabled : null

  tags = local.tags

  # DNS configuration
  dynamic "dns" {
    for_each = var.dns != null ? [var.dns] : []
    content {
      servers       = dns.value.servers
      search_domain = dns.value.search_domain
    }
  }

  # Default access policy
  dynamic "default_access_policy" {
    for_each = var.default_access_policy != null ? [var.default_access_policy] : []
    content {
      dynamic "access_rule" {
        for_each = default_access_policy.value
        content {
          scope                   = access_rule.value.scope
          access                  = access_rule.value.access
          anonymous_uid           = access_rule.value.anonymous_uid
          anonymous_gid           = access_rule.value.anonymous_gid
          filter                  = access_rule.value.filter
          root_squash_enabled     = access_rule.value.root_squash_enabled
          submount_access_enabled = access_rule.value.submount_access_enabled
          suid_enabled            = access_rule.value.suid_enabled
        }
      }
    }
  }

  # Managed identity
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  # Active Directory configuration
  dynamic "directory_active_directory" {
    for_each = var.directory_active_directory != null ? [var.directory_active_directory] : []
    content {
      dns_primary_ip      = directory_active_directory.value.dns_primary_ip
      domain_name         = directory_active_directory.value.domain_name
      cache_netbios_name  = directory_active_directory.value.cache_netbios_name
      domain_netbios_name = directory_active_directory.value.domain_netbios_name
      username            = directory_active_directory.value.username
      password            = directory_active_directory.value.password
      dns_secondary_ip    = directory_active_directory.value.dns_secondary_ip
    }
  }

  # Flat file directory configuration
  dynamic "directory_flat_file" {
    for_each = var.directory_flat_file != null ? [var.directory_flat_file] : []
    content {
      group_file_uri    = directory_flat_file.value.group_file_uri
      password_file_uri = directory_flat_file.value.password_file_uri
    }
  }

  # LDAP directory configuration
  dynamic "directory_ldap" {
    for_each = var.directory_ldap != null ? [var.directory_ldap] : []
    content {
      server                             = directory_ldap.value.server
      base_dn                            = directory_ldap.value.base_dn
      encrypted                          = directory_ldap.value.encrypted
      certificate_validation_uri         = directory_ldap.value.certificate_validation_uri
      download_certificate_automatically = directory_ldap.value.download_certificate_automatically

      dynamic "bind" {
        for_each = directory_ldap.value.bind != null ? [directory_ldap.value.bind] : []
        content {
          dn       = bind.value.dn
          password = bind.value.password
        }
      }
    }
  }
}
