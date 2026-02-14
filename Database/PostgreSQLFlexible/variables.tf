################################################################################
# Required Variables
################################################################################

variable "resource_group_name" {
  description = "The name of the resource group where the PostgreSQL Flexible Server will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the PostgreSQL Flexible Server will be created."
  type        = string
}

################################################################################
# Optional Variables - Naming
################################################################################

variable "name" {
  description = "The name of the PostgreSQL Flexible Server. If not provided, will be generated from naming variables."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix for the PostgreSQL Flexible Server name."
  type        = string
  default     = "psql"
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

variable "version" {
  description = "The version of PostgreSQL. Valid values are 11, 12, 13, 14, 15, and 16."
  type        = string
  default     = "16"

  validation {
    condition     = contains(["11", "12", "13", "14", "15", "16"], var.version)
    error_message = "Version must be 11, 12, 13, 14, 15, or 16."
  }
}

variable "sku_name" {
  description = "The SKU name for the PostgreSQL Flexible Server. Examples: B_Standard_B1ms, GP_Standard_D2s_v3, MO_Standard_E4s_v3."
  type        = string
  default     = "GP_Standard_D2s_v3"
}

variable "storage_mb" {
  description = "The storage size in MB for the PostgreSQL Flexible Server."
  type        = number
  default     = 32768

  validation {
    condition     = var.storage_mb >= 32768 && var.storage_mb <= 33554432
    error_message = "Storage must be between 32768 MB (32 GB) and 33554432 MB (32 TB)."
  }
}

variable "storage_tier" {
  description = "The storage tier. Possible values are P4, P6, P10, P15, P20, P30, P40, P50, P60, P70, P80."
  type        = string
  default     = null
}

variable "auto_grow_enabled" {
  description = "Whether storage auto-grow is enabled."
  type        = bool
  default     = true
}

variable "zone" {
  description = "The availability zone for the server."
  type        = string
  default     = null
}

variable "geo_redundant_backup_enabled" {
  description = "Whether geo-redundant backup is enabled."
  type        = bool
  default     = false
}

variable "backup_retention_days" {
  description = "The backup retention days for the PostgreSQL Flexible Server (7-35 days)."
  type        = number
  default     = 7

  validation {
    condition     = var.backup_retention_days >= 7 && var.backup_retention_days <= 35
    error_message = "Backup retention days must be between 7 and 35."
  }
}

################################################################################
# Optional Variables - Authentication
################################################################################

variable "administrator_login" {
  description = "The administrator login name. Required unless using Azure AD only authentication."
  type        = string
  default     = null
}

variable "administrator_password" {
  description = "The administrator password. Required unless using Azure AD only authentication."
  type        = string
  default     = null
  sensitive   = true
}

variable "authentication" {
  description = "Authentication configuration for the PostgreSQL Flexible Server."
  type = object({
    active_directory_auth_enabled = optional(bool, false)
    password_auth_enabled         = optional(bool, true)
    tenant_id                     = optional(string)
  })
  default = {}
}

################################################################################
# Optional Variables - Network
################################################################################

variable "delegated_subnet_id" {
  description = "The ID of the subnet for VNet integration."
  type        = string
  default     = null
}

variable "private_dns_zone_id" {
  description = "The ID of the private DNS zone for VNet integration."
  type        = string
  default     = null
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled. Cannot be true if delegated_subnet_id is set."
  type        = bool
  default     = false
}

################################################################################
# Optional Variables - High Availability
################################################################################

variable "high_availability" {
  description = "High availability configuration for the PostgreSQL Flexible Server."
  type = object({
    mode                      = string
    standby_availability_zone = optional(string)
  })
  default = null

  validation {
    condition     = var.high_availability == null || contains(["SameZone", "ZoneRedundant"], var.high_availability.mode)
    error_message = "High availability mode must be SameZone or ZoneRedundant."
  }
}

################################################################################
# Optional Variables - Maintenance Window
################################################################################

variable "maintenance_window" {
  description = "Maintenance window configuration for the PostgreSQL Flexible Server."
  type = object({
    day_of_week  = optional(number, 0)
    start_hour   = optional(number, 0)
    start_minute = optional(number, 0)
  })
  default = null
}

################################################################################
# Optional Variables - Customer Managed Key
################################################################################

variable "customer_managed_key" {
  description = "Customer managed key configuration for the PostgreSQL Flexible Server."
  type = object({
    key_vault_key_id                     = string
    primary_user_assigned_identity_id    = optional(string)
    geo_backup_key_vault_key_id          = optional(string)
    geo_backup_user_assigned_identity_id = optional(string)
  })
  default = null
}

################################################################################
# Optional Variables - Identity
################################################################################

variable "identity" {
  description = "Managed identity configuration for the PostgreSQL Flexible Server."
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = null
}

################################################################################
# Optional Variables - Databases
################################################################################

variable "databases" {
  description = "List of databases to create on the PostgreSQL Flexible Server."
  type = list(object({
    name      = string
    charset   = optional(string, "UTF8")
    collation = optional(string, "en_US.utf8")
  }))
  default = []
}

################################################################################
# Optional Variables - Server Parameters
################################################################################

variable "server_configurations" {
  description = "Map of server configuration parameters."
  type        = map(string)
  default     = {}
}

################################################################################
# Optional Variables - Firewall Rules
################################################################################

variable "firewall_rules" {
  description = "List of firewall rules for the PostgreSQL Flexible Server."
  type = list(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))
  default = []
}

################################################################################
# Optional Variables - Tags
################################################################################

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
