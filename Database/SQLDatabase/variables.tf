################################################################################
# Required Variables
################################################################################

variable "server_id" {
  description = "The ID of the SQL Server on which to create the database."
  type        = string
}

################################################################################
# Optional Variables - Naming
################################################################################

variable "name" {
  description = "The name of the SQL Database. If not provided, will be generated from naming variables."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix for the SQL Database name."
  type        = string
  default     = "sqldb"
}

variable "workload" {
  description = "The workload name for naming convention."
  type        = string
  default     = ""
}

variable "environment" {
  description = "The environment name (dev, staging, prod) for naming convention."
  type        = string
  default     = ""
}

variable "instance" {
  description = "The instance identifier for naming convention."
  type        = string
  default     = "001"
}

################################################################################
# Optional Variables - Configuration
################################################################################

variable "create" {
  description = "Controls whether resources should be created."
  type        = bool
  default     = true
}

variable "collation" {
  description = "The collation of the database."
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "license_type" {
  description = "The license type for the database. Valid values are LicenseIncluded or BasePrice."
  type        = string
  default     = "LicenseIncluded"

  validation {
    condition     = contains(["LicenseIncluded", "BasePrice"], var.license_type)
    error_message = "License type must be LicenseIncluded or BasePrice."
  }
}

variable "max_size_gb" {
  description = "The maximum size of the database in gigabytes."
  type        = number
  default     = null
}

variable "read_scale" {
  description = "Whether read-only connections are allowed. Only applicable for Premium and Business Critical SKUs."
  type        = bool
  default     = false
}

variable "zone_redundant" {
  description = "Whether the database is zone redundant. Only applicable for Premium and Business Critical SKUs."
  type        = bool
  default     = false
}

variable "auto_pause_delay_in_minutes" {
  description = "Time in minutes after which database is automatically paused. Only for Serverless tier. -1 means disabled."
  type        = number
  default     = null
}

variable "min_capacity" {
  description = "Minimum capacity for serverless database. Only for Serverless tier."
  type        = number
  default     = null
}

variable "ledger_enabled" {
  description = "Whether to enable ledger on the database."
  type        = bool
  default     = false
}

variable "geo_backup_enabled" {
  description = "Whether geo-redundant backup is enabled."
  type        = bool
  default     = true
}

variable "storage_account_type" {
  description = "The storage account type for the database backups. Valid values are Geo, Local, or Zone."
  type        = string
  default     = "Geo"

  validation {
    condition     = contains(["Geo", "Local", "Zone"], var.storage_account_type)
    error_message = "Storage account type must be Geo, Local, or Zone."
  }
}

################################################################################
# Optional Variables - SKU
################################################################################

variable "sku_name" {
  description = "The SKU name for the database. Examples: Basic, S0, S1, P1, GP_S_Gen5_2, GP_Gen5_2, BC_Gen5_2."
  type        = string
  default     = "GP_S_Gen5_2"
}

variable "elastic_pool_id" {
  description = "The ID of the elastic pool containing this database."
  type        = string
  default     = null
}

################################################################################
# Optional Variables - Restore/Copy
################################################################################

variable "create_mode" {
  description = "The creation mode. Valid values are Default, Copy, PointInTimeRestore, Recovery, Restore, RestoreExternalBackup, etc."
  type        = string
  default     = "Default"
}

variable "creation_source_database_id" {
  description = "The ID of the source database for Copy, PointInTimeRestore, etc."
  type        = string
  default     = null
}

variable "restore_point_in_time" {
  description = "The point in time for restore. Required when create_mode is PointInTimeRestore."
  type        = string
  default     = null
}

variable "recover_database_id" {
  description = "The ID of the database to recover. Required when create_mode is Recovery."
  type        = string
  default     = null
}

variable "restore_dropped_database_id" {
  description = "The ID of the dropped database to restore. Required when create_mode is Restore."
  type        = string
  default     = null
}

################################################################################
# Optional Variables - Short-term Retention
################################################################################

variable "short_term_retention_policy" {
  description = "Short-term backup retention policy configuration."
  type = object({
    retention_days           = number
    backup_interval_in_hours = optional(number, 12)
  })
  default = {
    retention_days           = 7
    backup_interval_in_hours = 12
  }

  validation {
    condition     = var.short_term_retention_policy.retention_days >= 7 && var.short_term_retention_policy.retention_days <= 35
    error_message = "Retention days must be between 7 and 35."
  }
}

################################################################################
# Optional Variables - Long-term Retention
################################################################################

variable "long_term_retention_policy" {
  description = "Long-term backup retention policy configuration."
  type = object({
    weekly_retention  = optional(string)
    monthly_retention = optional(string)
    yearly_retention  = optional(string)
    week_of_year      = optional(number)
  })
  default = null
}

################################################################################
# Optional Variables - Threat Detection
################################################################################

variable "threat_detection_policy" {
  description = "Threat detection policy configuration for the database."
  type = object({
    state                      = optional(string, "Enabled")
    disabled_alerts            = optional(list(string), [])
    email_account_admins       = optional(string, "Enabled")
    email_addresses            = optional(list(string), [])
    retention_days             = optional(number, 30)
    storage_endpoint           = optional(string)
    storage_account_access_key = optional(string)
  })
  default = null
}

################################################################################
# Optional Variables - Identity
################################################################################

variable "identity" {
  description = "Managed identity configuration for the database."
  type = object({
    type         = string
    identity_ids = list(string)
  })
  default = null
}

################################################################################
# Optional Variables - Transparent Data Encryption
################################################################################

variable "transparent_data_encryption_enabled" {
  description = "Whether Transparent Data Encryption is enabled."
  type        = bool
  default     = true
}

variable "transparent_data_encryption_key_vault_key_id" {
  description = "The Key Vault Key ID for TDE with customer-managed key."
  type        = string
  default     = null
}

variable "transparent_data_encryption_key_automatic_rotation_enabled" {
  description = "Whether automatic rotation is enabled for the TDE key."
  type        = bool
  default     = false
}

################################################################################
# Optional Variables - Tags
################################################################################

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
