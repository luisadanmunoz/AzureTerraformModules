#############################################################################
# VARIABLES NETAPP VOLUME
#############################################################################
variable "netapp_volume_name" {
  description = "value to set the netapp volume name"
  type        = string
}

variable "account_name" {
  description = "value to set the account name"
  type        = string
}

variable "pool_name" {
  description = "value to set the pool name"
  type        = string
}

variable "snapshot_policy_id" {
  description = "value to set the snapshot policy id"
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "location" {
  description = "value to set the location"
  type        = string
}

variable "service_level" {
  description = "value to set the service level"
  type        = string
}

variable "storage_quota_in_gb" {
  description = "value to set the storage quota in gb"
  type        = number
}

variable "subnet_id" {
  description = "value to set the subnet id"
  type        = string
}

variable "volume_path" {
  description = "value to set the volume path"
  type        = string
}

variable "accept_grow_capacity_pool_for_short_term_clone_split" {
  description = "value to set the accept grow capacity pool for short term clone split"
  type        = string
  default     = null
}

variable "azure_vmware_data_store_enabled" {
  description = "value to set the azure vmware data store enabled"
  type        = bool
  default     = null
}

variable "create_from_snapshot_resource_id" {
  description = "value to set the create from snapshot resource id"
  type        = string
  default     = null
}

variable "kerberos_enabled" {
  description = "value to set the kerberos enabled"
  type        = bool
  default     = null
}

variable "large_volume_enabled" {
  description = "value to set the large volume enabled"
  type        = bool
  default     = null
}

variable "network_features" {
  description = "value to set the network features"
  type        = string
  default     = null
}

variable "protocols" {
  description = "value to set the protocols"
  type        = list(string)
  default     = null
}

variable "security_style" {
  description = "value to set the security style"
  type        = string
  default     = null

  validation {
    condition     = var.security_style == null || contains(["ntfs", "unix"], var.security_style)
    error_message = "The netapp_volume security_style must be ntfs or unix."
  }
}

variable "smb3_protocol_encryption_enabled" {
  description = "value to set the smb3 protocol encryption enabled"
  type        = bool
  default     = null
}

variable "smb_access_based_enumeration_enabled" {
  description = "value to set the smb access based enumeration enabled"
  type        = bool
  default     = null
}

variable "smb_continuous_availability_enabled" {
  description = "value to set the smb continuous availability enabled"
  type        = bool
  default     = null
}

variable "smb_non_browsable_enabled" {
  description = "value to set the smb non browsable enabled"
  type        = bool
  default     = null
}

variable "snapshot_directory_visible" {
  description = "value to set the snapshot directory visible"
  type        = bool
  default     = null
}

variable "throughput_in_mibps" {
  description = "value to set the throughput in mibps"
  type        = number
  default     = null
}

variable "zone" {
  description = "value to set the zone"
  type        = string
  default     = null
}

variable "cool_access" {
  description = "value to set the cool access"
  type = object({
    coolness_period_in_days = number
    retrieval_policy        = string
    tiering_policy          = string
  })
  default = null
}

variable "data_protection_advanced_ransomware" {
  description = "value to set the data protection advanced ransomware"
  type = object({
    protection_enabled = bool
  })
  default = null
}

variable "data_protection_backup_policy" {
  description = "value to set the data protection backup policy"
  type = object({
    backup_policy_id = string
    backup_vault_id  = string
    policy_enabled   = optional(bool)
  })
  default = null
}

variable "data_protection_replication" {
  description = "value to set the data protection replication"
  type = object({
    remote_volume_location    = string
    remote_volume_resource_id = string
    replication_frequency     = string
    endpoint_type             = optional(string)
  })
  default = null
}

variable "export_policy_rules" {
  description = "value to set the export policy rules"
  type = list(object({
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
  }))
  default = []
}

variable "timeouts" {
  description = "value to set the timeouts"
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
