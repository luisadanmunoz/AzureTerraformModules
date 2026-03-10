################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Recovery Services Vault."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Vault should exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Optional) The name of the Recovery Services Vault. If not provided, a name will be generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for the generated name. Default: 'rsv'."
  type        = string
  default     = "rsv"
}

variable "workload" {
  description = "(Optional) Workload name for the naming convention."
  type        = string
  default     = "backup"
}

variable "environment" {
  description = "(Optional) Environment name (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "instance" {
  description = "(Optional) Instance number for the naming convention."
  type        = string
  default     = "001"
}

################################################################################
# Vault Configuration
################################################################################

variable "sku" {
  description = "(Optional) The SKU of the Vault. Values: Standard, RS0. Default: Standard."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "RS0"], var.sku)
    error_message = "sku must be Standard or RS0."
  }
}

variable "storage_mode_type" {
  description = "(Optional) The storage type. Values: GeoRedundant, LocallyRedundant, ZoneRedundant. Default: GeoRedundant."
  type        = string
  default     = "GeoRedundant"

  validation {
    condition     = contains(["GeoRedundant", "LocallyRedundant", "ZoneRedundant"], var.storage_mode_type)
    error_message = "storage_mode_type must be GeoRedundant, LocallyRedundant, or ZoneRedundant."
  }
}

variable "cross_region_restore_enabled" {
  description = "(Optional) Enable cross-region restore. Only for GeoRedundant. Default: false."
  type        = bool
  default     = false
}

variable "soft_delete_enabled" {
  description = "(Optional) Enable soft delete for backup items. Default: true."
  type        = bool
  default     = true
}

variable "immutability" {
  description = "(Optional) Immutability setting. Values: Disabled, Unlocked, Locked. Default: Disabled."
  type        = string
  default     = "Disabled"

  validation {
    condition     = contains(["Disabled", "Unlocked", "Locked"], var.immutability)
    error_message = "immutability must be Disabled, Unlocked, or Locked."
  }
}

variable "public_network_access_enabled" {
  description = "(Optional) Enable public network access. Default: true."
  type        = bool
  default     = true
}

variable "classic_vmware_replication_enabled" {
  description = "(Optional) Enable classic VMware replication. Default: false."
  type        = bool
  default     = false
}

################################################################################
# Identity
################################################################################

variable "identity" {
  description = <<-EOT
    (Optional) Identity configuration for CMK encryption.
    - type: Identity type. Values: SystemAssigned, UserAssigned.
    - identity_ids: List of User Assigned Identity IDs.
  EOT
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = null
}

################################################################################
# Encryption
################################################################################

variable "encryption" {
  description = <<-EOT
    (Optional) Customer Managed Key encryption configuration.
    - key_id: The Key Vault Key ID.
    - infrastructure_encryption_enabled: Enable infrastructure encryption.
    - use_system_assigned_identity: Use system or user assigned identity.
    - user_assigned_identity_id: User assigned identity for key access.
  EOT
  type = object({
    key_id                             = string
    infrastructure_encryption_enabled  = optional(bool, false)
    use_system_assigned_identity       = optional(bool, true)
    user_assigned_identity_id          = optional(string, null)
  })
  default = null
}

################################################################################
# Monitoring
################################################################################

variable "monitoring" {
  description = <<-EOT
    (Optional) Monitoring and alerting configuration.
    - alerts_for_all_job_failures_enabled: Alert on job failures.
    - alerts_for_critical_operation_failures_enabled: Alert on critical failures.
  EOT
  type = object({
    alerts_for_all_job_failures_enabled            = optional(bool, true)
    alerts_for_critical_operation_failures_enabled = optional(bool, true)
  })
  default = {}
}

################################################################################
# Diagnostic Settings
################################################################################

variable "diagnostic_settings" {
  description = <<-EOT
    (Optional) Diagnostic settings for the Vault.
    - name: Name of the diagnostic setting.
    - log_analytics_workspace_id: Log Analytics Workspace ID.
    - storage_account_id: Storage Account ID for archival.
    - eventhub_authorization_rule_id: Event Hub authorization rule ID.
    - eventhub_name: Event Hub name.
    - log_categories: List of log categories to enable.
  EOT
  type = object({
    name                           = optional(string, "diag-rsv")
    log_analytics_workspace_id     = optional(string, null)
    storage_account_id             = optional(string, null)
    eventhub_authorization_rule_id = optional(string, null)
    eventhub_name                  = optional(string, null)
    log_categories = optional(list(string), [
      "CoreAzureBackup",
      "AddonAzureBackupJobs",
      "AddonAzureBackupAlerts",
      "AddonAzureBackupPolicy",
      "AddonAzureBackupStorage",
      "AddonAzureBackupProtectedInstance",
      "AzureBackupReport",
      "AzureSiteRecoveryJobs",
      "AzureSiteRecoveryEvents",
      "AzureSiteRecoveryReplicatedItems"
    ])
  })
  default = null
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
