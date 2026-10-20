#############################################################################
# GLOBAL TAGS
#############################################################################
variable "tags" {
  description = "value to set the global tags"
  type        = map(string)
  default     = {}
}

#############################################################################
# RESOURCE GROUPS
#############################################################################
variable "resources_groups" {
  description = "value to set the resources groups"
  type = map(object({
    resource_group_name = string
    location            = string
    tags                = optional(map(string))
  }))
  default = {}
}

#############################################################################
# STORAGE ACCOUNTS
#############################################################################
variable "storage_accounts" {
  description = "value to set the storage accounts"
  type = map(object({
    storage_account_name              = string
    resource_group_name               = optional(string)
    location                          = string
    account_tier                      = string
    account_replication_type          = string
    access_tier                       = optional(string)
    account_kind                      = optional(string)
    allow_nested_items_to_be_public   = optional(bool)
    cross_tenant_replication_enabled  = optional(bool)
    default_to_oauth_authentication   = optional(bool)
    https_traffic_only_enabled        = optional(bool)
    infrastructure_encryption_enabled = optional(bool)
    is_hns_enabled                    = optional(bool)
    large_file_share_enabled          = optional(bool)
    local_user_enabled                = optional(bool)
    min_tls_version                   = optional(string)
    nfsv3_enabled                     = optional(bool)
    public_network_access_enabled     = optional(bool)
    sftp_enabled                      = optional(bool)
    shared_access_key_enabled         = optional(bool)
    blob_properties = optional(object({
      change_feed_enabled           = optional(bool)
      change_feed_retention_in_days = optional(number)
      last_access_time_enabled      = optional(bool)
      versioning_enabled            = optional(bool)
      container_delete_retention_policy = optional(object({
        days = optional(number)
      }))
      delete_retention_policy = optional(object({
        days                     = optional(number)
        permanent_delete_enabled = optional(bool)
      }))
      restore_policy = optional(object({
        days = number
      }))
    }))
    custom_domain = optional(object({
      name          = string
      use_subdomain = optional(bool)
    }))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    network_rules = optional(object({
      default_action             = string
      bypass                     = optional(list(string))
      ip_rules                   = optional(list(string))
      virtual_network_subnet_ids = optional(list(string))
      private_link_access = optional(list(object({
        endpoint_resource_id = string
        endpoint_tenant_id   = optional(string)
      })))
    }))
    queue_properties = optional(object({
      cors_rules = optional(list(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      })))
      logging = optional(object({
        delete                = bool
        read                  = bool
        retention_policy_days = optional(number)
        version               = string
        write                 = bool
      }))
      hour_metrics = optional(object({
        enabled               = bool
        include_apis          = optional(bool)
        retention_policy_days = optional(number)
        version               = string
      }))
      minute_metrics = optional(object({
        enabled               = bool
        include_apis          = optional(bool)
        retention_policy_days = optional(number)
        version               = string
      }))
    }))
    routing = optional(object({
      choice                      = optional(string)
      publish_internet_endpoints  = optional(bool)
      publish_microsoft_endpoints = optional(bool)
    }))
    sas_policy = optional(object({
      expiration_period = string
      expiration_action = optional(string)
    }))
    share_properties = optional(object({
      cors_rules = optional(list(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      })))
      retention_policy = optional(object({
        days = optional(number)
      }))
      smb = optional(object({
        authentication_types            = optional(list(string))
        channel_encryption_type         = optional(list(string))
        kerberos_ticket_encryption_type = optional(list(string))
        multichannel_enabled            = optional(bool)
        versions                        = optional(list(string))
      }))
    }))
    static_website = optional(object({
      index_document     = optional(string)
      error_404_document = optional(string)
    }))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# STORAGE CONTAINERS
#############################################################################
variable "storage_containers" {
  description = "value to set the storage containers"
  type = map(object({
    storage_container_name            = string
    storage_account_name              = optional(string)
    storage_account_id                = optional(string)
    container_access_type             = optional(string)
    default_encryption_scope          = optional(string)
    encryption_scope_override_enabled = optional(bool)
    metadata                          = optional(map(string))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# STORAGE SHARES
#############################################################################
variable "storage_shares" {
  description = "value to set the storage shares"
  type = map(object({
    storage_share_name   = string
    storage_account_name = optional(string)
    storage_account_id   = optional(string)
    quota                = number
    access_tier          = optional(string)
    enabled_protocol     = optional(string)
    metadata             = optional(map(string))
    acl = optional(list(object({
      id = string
      access_policy = optional(object({
        start       = optional(string)
        expiry      = optional(string)
        permissions = string
      }))
    })))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# STORAGE QUEUES
#############################################################################
variable "storage_queues" {
  description = "value to set the storage queues"
  type = map(object({
    storage_queue_name   = string
    storage_account_name = optional(string)
    storage_account_id   = optional(string)
    metadata             = optional(map(string))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# STORAGE TABLES
#############################################################################
variable "storage_tables" {
  description = "value to set the storage tables"
  type = map(object({
    storage_table_name   = string
    storage_account_name = optional(string)
    acl = optional(list(object({
      id = string
      access_policy = optional(object({
        start       = string
        expiry      = string
        permissions = string
      }))
    })))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# STORAGE MANAGEMENT POLICIES
#############################################################################
variable "storage_management_policies" {
  description = "value to set the storage management policies"
  type = map(object({
    storage_account_name = optional(string)
    storage_account_id   = optional(string)
    rules = list(object({
      name    = string
      enabled = bool
      filters = object({
        blob_types   = list(string)
        prefix_match = optional(list(string))
      })
      actions = object({
        base_blob = optional(object({
          auto_tier_to_hot_from_cool_enabled                             = optional(bool)
          delete_after_days_since_creation_greater_than                  = optional(number)
          delete_after_days_since_last_access_time_greater_than          = optional(number)
          delete_after_days_since_modification_greater_than              = optional(number)
          tier_to_archive_after_days_since_creation_greater_than         = optional(number)
          tier_to_archive_after_days_since_last_access_time_greater_than = optional(number)
          tier_to_archive_after_days_since_last_tier_change_greater_than = optional(number)
          tier_to_archive_after_days_since_modification_greater_than     = optional(number)
          tier_to_cold_after_days_since_creation_greater_than            = optional(number)
          tier_to_cold_after_days_since_last_access_time_greater_than    = optional(number)
          tier_to_cold_after_days_since_modification_greater_than        = optional(number)
          tier_to_cool_after_days_since_creation_greater_than            = optional(number)
          tier_to_cool_after_days_since_last_access_time_greater_than    = optional(number)
          tier_to_cool_after_days_since_modification_greater_than        = optional(number)
        }))
        snapshot = optional(object({
          change_tier_to_archive_after_days_since_creation               = optional(number)
          change_tier_to_cool_after_days_since_creation                  = optional(number)
          delete_after_days_since_creation_greater_than                  = optional(number)
          tier_to_archive_after_days_since_last_tier_change_greater_than = optional(number)
          tier_to_cold_after_days_since_creation_greater_than            = optional(number)
        }))
        version = optional(object({
          change_tier_to_archive_after_days_since_creation               = optional(number)
          change_tier_to_cool_after_days_since_creation                  = optional(number)
          delete_after_days_since_creation                               = optional(number)
          tier_to_archive_after_days_since_last_tier_change_greater_than = optional(number)
          tier_to_cold_after_days_since_creation_greater_than            = optional(number)
        }))
      })
    }))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# STORAGE DATA LAKE GEN2 FILESYSTEMS
#############################################################################
variable "storage_data_lake_gen2_filesystems" {
  description = "value to set the storage data lake gen2 filesystems"
  type = map(object({
    storage_data_lake_gen2_filesystem_name = string
    storage_account_name                   = optional(string)
    storage_account_id                     = optional(string)
    default_encryption_scope               = optional(string)
    properties                             = optional(map(string))
    ace = optional(list(object({
      id          = optional(string)
      permissions = string
      scope       = optional(string)
      type        = string
    })))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# NETAPP ACCOUNTS
#############################################################################
variable "netapp_accounts" {
  description = "value to set the netapp accounts"
  type = map(object({
    netapp_account_name = string
    resource_group_name = optional(string)
    location            = string
    active_directory = optional(object({
      dns_servers                       = list(string)
      domain                            = string
      smb_server_name                   = string
      username                          = string
      password                          = string
      aes_encryption_enabled            = optional(bool)
      kerberos_ad_name                  = optional(string)
      kerberos_kdc_ip                   = optional(string)
      ldap_over_tls_enabled             = optional(bool)
      ldap_signing_enabled              = optional(bool)
      local_nfs_users_with_ldap_allowed = optional(bool)
      organizational_unit               = optional(string)
      server_root_ca_certificate        = optional(string)
      site_name                         = optional(string)
    }))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# NETAPP POOLS
#############################################################################
variable "netapp_pools" {
  description = "value to set the netapp pools"
  type = map(object({
    netapp_pool_name        = string
    netapp_account_name     = optional(string)
    resource_group_name     = optional(string)
    location                = string
    service_level           = string
    size_in_tb              = number
    cool_access_enabled     = optional(bool)
    custom_throughput_mibps = optional(number)
    encryption_type         = optional(string)
    qos_type                = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# NETAPP SNAPSHOT POLICIES
#############################################################################
variable "netapp_snapshot_policies" {
  description = "value to set the netapp snapshot policies"
  type = map(object({
    netapp_snapshot_policy_name = string
    netapp_account_name         = optional(string)
    resource_group_name         = optional(string)
    location                    = string
    enabled                     = bool
    hourly_schedule = optional(object({
      minute            = number
      snapshots_to_keep = number
    }))
    daily_schedule = optional(object({
      hour              = number
      minute            = number
      snapshots_to_keep = number
    }))
    weekly_schedule = optional(object({
      days_of_week      = list(string)
      hour              = number
      minute            = number
      snapshots_to_keep = number
    }))
    monthly_schedule = optional(object({
      days_of_month     = list(number)
      hour              = number
      minute            = number
      snapshots_to_keep = number
    }))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# NETAPP VOLUMES
#############################################################################
variable "netapp_volumes" {
  description = "value to set the netapp volumes"
  type = map(object({
    netapp_volume_name                                   = string
    netapp_account_name                                  = optional(string)
    netapp_pool_name                                     = optional(string)
    netapp_snapshot_policy_name                          = optional(string)
    snapshot_policy_id                                   = optional(string)
    resource_group_name                                  = optional(string)
    location                                             = string
    service_level                                        = string
    storage_quota_in_gb                                  = number
    subnet_id                                            = string
    volume_path                                          = string
    accept_grow_capacity_pool_for_short_term_clone_split = optional(string)
    azure_vmware_data_store_enabled                      = optional(bool)
    create_from_snapshot_resource_id                     = optional(string)
    kerberos_enabled                                     = optional(bool)
    large_volume_enabled                                 = optional(bool)
    network_features                                     = optional(string)
    protocols                                            = optional(list(string))
    security_style                                       = optional(string)
    smb3_protocol_encryption_enabled                     = optional(bool)
    smb_access_based_enumeration_enabled                 = optional(bool)
    smb_continuous_availability_enabled                  = optional(bool)
    smb_non_browsable_enabled                            = optional(bool)
    snapshot_directory_visible                           = optional(bool)
    throughput_in_mibps                                  = optional(number)
    zone                                                 = optional(string)
    cool_access = optional(object({
      coolness_period_in_days = number
      retrieval_policy        = string
      tiering_policy          = string
    }))
    data_protection_advanced_ransomware = optional(object({
      protection_enabled = bool
    }))
    data_protection_backup_policy = optional(object({
      backup_policy_id = string
      backup_vault_id  = string
      policy_enabled   = optional(bool)
    }))
    data_protection_replication = optional(object({
      remote_volume_location    = string
      remote_volume_resource_id = string
      replication_frequency     = string
      endpoint_type             = optional(string)
    }))
    export_policy_rules = optional(list(object({
      allowed_clients                = list(string)
      rule_index                     = number
      kerberos_5_read_only_enabled   = optional(bool)
      kerberos_5_read_write_enabled  = optional(bool)
      kerberos_5i_read_only_enabled  = optional(bool)
      kerberos_5i_read_write_enabled = optional(bool)
      kerberos_5p_read_only_enabled  = optional(bool)
      kerberos_5p_read_write_enabled = optional(bool)
      protocol                       = optional(list(string))
      protocols_enabled              = optional(list(string))
      root_access_enabled            = optional(bool)
      unix_read_only                 = optional(bool)
      unix_read_write                = optional(bool)
    })))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}
