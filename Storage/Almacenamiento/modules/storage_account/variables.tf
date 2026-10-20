#############################################################################
# VARIABLES STORAGE ACCOUNT
#############################################################################
variable "storage_account_name" {
  description = "value to set the storage account name"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "The storage_account_name must be 3-24 lowercase alphanumeric characters."
  }
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "location" {
  description = "value to set the location"
  type        = string
}

variable "account_tier" {
  description = "value to set the account tier"
  type        = string
}

variable "account_replication_type" {
  description = "value to set the account replication type"
  type        = string
}

variable "access_tier" {
  description = "value to set the access tier"
  type        = string
  default     = null
}

variable "account_kind" {
  description = "value to set the account kind"
  type        = string
  default     = null
}

variable "allow_nested_items_to_be_public" {
  description = "value to set the allow nested items to be public"
  type        = bool
  default     = null
}

variable "cross_tenant_replication_enabled" {
  description = "value to set the cross tenant replication enabled"
  type        = bool
  default     = null
}

variable "default_to_oauth_authentication" {
  description = "value to set the default to oauth authentication"
  type        = bool
  default     = null
}

variable "https_traffic_only_enabled" {
  description = "value to set the https traffic only enabled"
  type        = bool
  default     = null
}

variable "infrastructure_encryption_enabled" {
  description = "value to set the infrastructure encryption enabled"
  type        = bool
  default     = null
}

variable "is_hns_enabled" {
  description = "value to set the is hns enabled"
  type        = bool
  default     = null
}

variable "large_file_share_enabled" {
  description = "value to set the large file share enabled"
  type        = bool
  default     = null
}

variable "local_user_enabled" {
  description = "value to set the local user enabled"
  type        = bool
  default     = null
}

variable "min_tls_version" {
  description = "value to set the min tls version"
  type        = string
  default     = null
}

variable "nfsv3_enabled" {
  description = "value to set the nfsv3 enabled"
  type        = bool
  default     = null
}

variable "public_network_access_enabled" {
  description = "value to set the public network access enabled"
  type        = bool
  default     = null
}

variable "sftp_enabled" {
  description = "value to set the sftp enabled"
  type        = bool
  default     = null
}

variable "shared_access_key_enabled" {
  description = "value to set the shared access key enabled"
  type        = bool
  default     = null
}

variable "blob_properties" {
  description = "value to set the blob properties"
  type = object({
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
  })
  default = null
}

variable "custom_domain" {
  description = "value to set the custom domain"
  type = object({
    name          = string
    use_subdomain = optional(bool)
  })
  default = null
}

variable "identity" {
  description = "value to set the identity"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "network_rules" {
  description = "value to set the network rules"
  type = object({
    default_action             = string
    bypass                     = optional(list(string))
    ip_rules                   = optional(list(string))
    virtual_network_subnet_ids = optional(list(string))
    private_link_access = optional(list(object({
      endpoint_resource_id = string
      endpoint_tenant_id   = optional(string)
    })))
  })
  default = null
}

variable "queue_properties" {
  description = "value to set the queue properties"
  type = object({
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
  })
  default = null
}

variable "routing" {
  description = "value to set the routing"
  type = object({
    choice                      = optional(string)
    publish_internet_endpoints  = optional(bool)
    publish_microsoft_endpoints = optional(bool)
  })
  default = null
}

variable "sas_policy" {
  description = "value to set the sas policy"
  type = object({
    expiration_period = string
    expiration_action = optional(string)
  })
  default = null
}

variable "share_properties" {
  description = "value to set the share properties"
  type = object({
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
  })
  default = null
}

variable "static_website" {
  description = "value to set the static website"
  type = object({
    index_document     = optional(string)
    error_404_document = optional(string)
  })
  default = null
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
