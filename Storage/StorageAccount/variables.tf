################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Storage Account. Set to false to disable resource creation without removing module code."
  type        = bool
  default     = true
}

################################################################################
# Required Variables - Dependencies
################################################################################

variable "resource_group_name" {
  description = <<-EOT
    (Required) The name of the Resource Group where the Storage Account will be created.
    DEPENDENCY: Resource Group must exist before creating the Storage Account.
  EOT
  type        = string

  validation {
    condition     = var.resource_group_name != null && var.resource_group_name != ""
    error_message = "resource_group_name is required and cannot be empty."
  }
}

variable "location" {
  description = <<-EOT
    (Required) The Azure region where the Storage Account will be deployed.
    DEPENDENCY: Should match the Resource Group location for optimal performance.
  EOT
  type        = string

  validation {
    condition     = var.location != null && var.location != ""
    error_message = "location is required and cannot be empty."
  }
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) The explicit name for the Storage Account. If provided, overrides name_prefix/workload/environment/instance logic. Must be 3-24 characters, lowercase letters and numbers only."
  type        = string
  default     = null

  validation {
    condition     = var.name == null || can(regex("^[a-z0-9]{3,24}$", var.name))
    error_message = "Storage Account name must be 3-24 characters long and contain only lowercase letters and numbers."
  }
}

variable "name_prefix" {
  description = "(Optional) Prefix to prepend to the generated Storage Account name. Used when 'name' is not provided. Default is 'st'."
  type        = string
  default     = "st"
}

variable "workload" {
  description = "(Optional) The workload or application name, used for naming convention."
  type        = string
  default     = "shared"
}

variable "environment" {
  description = "(Optional) The environment name (e.g., dev, staging, prod), used for naming convention."
  type        = string
  default     = "dev"
}

variable "instance" {
  description = "(Optional) Instance number or identifier for naming convention."
  type        = string
  default     = "001"
}

################################################################################
# Storage Account Configuration
################################################################################

variable "account_tier" {
  description = "(Optional) Defines the Tier to use for this Storage Account. Valid options are Standard and Premium."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "account_tier must be either 'Standard' or 'Premium'."
  }
}

variable "account_replication_type" {
  description = "(Optional) Defines the type of replication to use for this Storage Account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS, and RAGZRS."
  type        = string
  default     = "LRS"

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.account_replication_type)
    error_message = "account_replication_type must be one of: LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS."
  }
}

variable "account_kind" {
  description = "(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage, and StorageV2."
  type        = string
  default     = "StorageV2"

  validation {
    condition     = contains(["BlobStorage", "BlockBlobStorage", "FileStorage", "Storage", "StorageV2"], var.account_kind)
    error_message = "account_kind must be one of: BlobStorage, BlockBlobStorage, FileStorage, Storage, StorageV2."
  }
}

variable "access_tier" {
  description = "(Optional) Defines the access tier for BlobStorage, FileStorage, and StorageV2 accounts. Valid options are Hot and Cool."
  type        = string
  default     = "Hot"

  validation {
    condition     = contains(["Hot", "Cool"], var.access_tier)
    error_message = "access_tier must be either 'Hot' or 'Cool'."
  }
}

variable "min_tls_version" {
  description = "(Optional) The minimum supported TLS version for the Storage Account. Default is TLS1_2 for security."
  type        = string
  default     = "TLS1_2"
}

variable "enable_https_traffic_only" {
  description = "(Optional) Forces HTTPS traffic only. Recommended for security."
  type        = bool
  default     = true
}

variable "allow_nested_items_to_be_public" {
  description = "(Optional) Allow or disallow nested items within this Account to opt into being public. Default is false for security."
  type        = bool
  default     = false
}

variable "shared_access_key_enabled" {
  description = "(Optional) Indicates whether the Storage Account permits requests to be authorized with the account access key via Shared Key."
  type        = bool
  default     = true
}

variable "is_hns_enabled" {
  description = "(Optional) Is Hierarchical Namespace enabled? This is used for Azure Data Lake Storage Gen2."
  type        = bool
  default     = false
}

variable "nfsv3_enabled" {
  description = "(Optional) Is NFSv3 protocol enabled? Requires is_hns_enabled set to true and account_tier set to Premium."
  type        = bool
  default     = false
}

variable "large_file_share_enabled" {
  description = "(Optional) Is Large File Share Enabled?"
  type        = bool
  default     = false
}

variable "infrastructure_encryption_enabled" {
  description = "(Optional) Is infrastructure encryption enabled? Provides an additional layer of encryption. Default is true for security."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "(Optional) Whether the public network access is enabled. Default is false for security."
  type        = bool
  default     = false
}

variable "default_to_oauth_authentication" {
  description = "(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account."
  type        = bool
  default     = true
}

variable "cross_tenant_replication_enabled" {
  description = "(Optional) Should cross-tenant replication be enabled? Default is false for security."
  type        = bool
  default     = false
}

################################################################################
# Network Rules
################################################################################

variable "network_rules" {
  description = <<-EOT
    (Optional) Network rules configuration for the Storage Account.

    Attributes:
      - default_action: Specifies the default action of allow or deny when no other rules match. Valid options are Allow and Deny.
      - bypass: Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None.
      - ip_rules: List of public IP or IP ranges in CIDR format.
      - virtual_network_subnet_ids: List of virtual network subnet IDs to secure the Storage Account.
      - private_link_access: List of private link access rules.
  EOT
  type = object({
    default_action             = optional(string, "Deny")
    bypass                     = optional(set(string), ["AzureServices"])
    ip_rules                   = optional(list(string), [])
    virtual_network_subnet_ids = optional(list(string), [])
    private_link_access = optional(list(object({
      endpoint_resource_id = string
      endpoint_tenant_id   = optional(string, null)
    })), [])
  })
  default = null
}

################################################################################
# Blob Properties
################################################################################

variable "blob_properties" {
  description = <<-EOT
    (Optional) Blob properties configuration for the Storage Account.

    Attributes:
      - versioning_enabled: Is versioning enabled?
      - change_feed_enabled: Is the blob service properties for change feed events enabled?
      - change_feed_retention_in_days: The duration of change feed events retention in days (1-146000).
      - last_access_time_enabled: Is the last access time based tracking enabled?
      - delete_retention_policy: Specifies the number of days that the blob should be retained (1-365).
      - container_delete_retention_policy: Specifies the number of days that the container should be retained (1-365).
      - cors_rule: CORS rules for the blob service.
  EOT
  type = object({
    versioning_enabled            = optional(bool, true)
    change_feed_enabled           = optional(bool, true)
    change_feed_retention_in_days = optional(number, 30)
    last_access_time_enabled      = optional(bool, false)
    delete_retention_policy = optional(object({
      days = optional(number, 7)
    }), null)
    container_delete_retention_policy = optional(object({
      days = optional(number, 7)
    }), null)
    cors_rule = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })), [])
  })
  default = null
}

################################################################################
# Identity
################################################################################

variable "identity" {
  description = <<-EOT
    (Optional) Managed identity configuration for the Storage Account.

    Attributes:
      - type: Specifies the type of Managed Identity. Possible values are SystemAssigned, UserAssigned, or SystemAssigned, UserAssigned.
      - identity_ids: A list of User Assigned Managed Identity IDs to be assigned.
  EOT
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = null

  validation {
    condition     = var.identity == null || contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity.type)
    error_message = "identity.type must be one of: 'SystemAssigned', 'UserAssigned', or 'SystemAssigned, UserAssigned'."
  }
}

################################################################################
# Customer Managed Key
################################################################################

variable "customer_managed_key" {
  description = <<-EOT
    (Optional) Customer Managed Key configuration for the Storage Account.
    DEPENDENCY: Key Vault Key and User Assigned Identity must exist before referencing.

    Attributes:
      - key_vault_key_id: The ID of the Key Vault Key.
      - user_assigned_identity_id: The ID of a User Assigned Identity.
  EOT
  type = object({
    key_vault_key_id          = string
    user_assigned_identity_id = string
  })
  default = null
}

################################################################################
# Immutability Policy
################################################################################

variable "immutability_policy" {
  description = <<-EOT
    (Optional) Immutability policy configuration for the Storage Account.

    Attributes:
      - allow_protected_append_writes: When enabled, new blocks can be written to an append blob while maintaining immutability.
      - period_since_creation_in_days: The immutability period for the blobs in the container since the policy creation, in days.
      - state: Defines the mode of the policy. Valid options are Disabled, Unlocked, and Locked.
  EOT
  type = object({
    allow_protected_append_writes = optional(bool, true)
    period_since_creation_in_days = number
    state                         = optional(string, "Disabled")
  })
  default = null

  validation {
    condition     = var.immutability_policy == null || contains(["Disabled", "Unlocked", "Locked"], var.immutability_policy.state)
    error_message = "immutability_policy.state must be one of: 'Disabled', 'Unlocked', or 'Locked'."
  }
}

################################################################################
# Static Website
################################################################################

variable "static_website" {
  description = <<-EOT
    (Optional) Static website configuration for the Storage Account.

    Attributes:
      - index_document: The webpage that Azure Storage serves for requests to the root of a website or any subfolder.
      - error_404_document: The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file.
  EOT
  type = object({
    index_document     = optional(string, "index.html")
    error_404_document = optional(string, null)
  })
  default = null
}

################################################################################
# Custom Domain
################################################################################

variable "custom_domain" {
  description = <<-EOT
    (Optional) Custom domain configuration for the Storage Account.

    Attributes:
      - name: The Custom Domain Name to use for the Storage Account.
      - use_subdomain: Should the indirect CNAME validation method be used?
  EOT
  type = object({
    name          = string
    use_subdomain = optional(bool, false)
  })
  default = null
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A map of tags to assign to the Storage Account."
  type        = map(string)
  default     = {}
}

################################################################################
# Diagnostic Settings (Optional)
################################################################################

variable "diagnostic_settings" {
  description = <<-EOT
    (Optional) Diagnostic settings configuration for the Storage Account.
    DEPENDENCY: Log Analytics Workspace, Storage Account, or Event Hub must exist before referencing.

    Attributes:
      - name: Name of the diagnostic setting.
      - log_analytics_workspace_id: Resource ID of the Log Analytics Workspace.
      - storage_account_id: Resource ID of the Storage Account for archival.
      - eventhub_authorization_rule_id: Authorization rule ID for Event Hub.
      - eventhub_name: Name of the Event Hub.
      - log_categories: List of log categories to enable.
      - metric_categories: List of metric categories to enable.
  EOT
  type = object({
    name                           = optional(string, "diag-storageaccount")
    log_analytics_workspace_id     = optional(string, null)
    storage_account_id             = optional(string, null)
    eventhub_authorization_rule_id = optional(string, null)
    eventhub_name                  = optional(string, null)
    log_categories                 = optional(list(string), [])
    metric_categories              = optional(list(string), ["Transaction", "Capacity"])
  })
  default = null
}
