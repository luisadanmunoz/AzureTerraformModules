################################################################################
# Required Variables
################################################################################

# DEPENDENCY: Resource Group must exist
variable "resource_group_name" {
  description = "The name of the resource group where the MySQL Flexible Server will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the MySQL Flexible Server will be created."
  type        = string
}

################################################################################
# Optional Variables - Naming
################################################################################

variable "name" {
  description = "The name of the MySQL Flexible Server. If not provided, will be generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix for the MySQL Flexible Server name."
  type        = string
  default     = "mysql"
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
  description = "The version of MySQL to use. Possible values are 5.7 and 8.0.21."
  type        = string
  default     = "8.0.21"

  validation {
    condition     = contains(["5.7", "8.0.21"], var.version)
    error_message = "MySQL version must be 5.7 or 8.0.21."
  }
}

variable "sku_name" {
  description = "The SKU name for the MySQL Flexible Server."
  type        = string
  default     = "GP_Standard_D2ds_v4"
}

variable "administrator_login" {
  description = "The administrator login name for the MySQL Flexible Server."
  type        = string
  default     = "mysqladmin"
}

variable "administrator_password" {
  description = "The administrator password for the MySQL Flexible Server."
  type        = string
  sensitive   = true
}

variable "zone" {
  description = "The availability zone for the MySQL Flexible Server."
  type        = string
  default     = null
}

################################################################################
# Optional Variables - Storage
################################################################################

variable "storage" {
  description = "Storage configuration for the MySQL Flexible Server."
  type = object({
    auto_grow_enabled  = optional(bool, true)
    io_scaling_enabled = optional(bool, false)
    iops               = optional(number)
    size_gb            = optional(number, 20)
  })
  default = {
    auto_grow_enabled = true
    size_gb           = 20
  }
}

################################################################################
# Optional Variables - Backup
################################################################################

variable "backup_retention_days" {
  description = "The backup retention days for the MySQL Flexible Server (1-35 days)."
  type        = number
  default     = 7

  validation {
    condition     = var.backup_retention_days >= 1 && var.backup_retention_days <= 35
    error_message = "Backup retention days must be between 1 and 35."
  }
}

variable "geo_redundant_backup_enabled" {
  description = "Enable geo-redundant backup for the MySQL Flexible Server."
  type        = bool
  default     = false
}

################################################################################
# Optional Variables - High Availability
################################################################################

variable "high_availability" {
  description = "High availability configuration for the MySQL Flexible Server."
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
# Optional Variables - Network
################################################################################

# DEPENDENCY: Subnet must exist with Microsoft.DBforMySQL/flexibleServers delegation
variable "delegated_subnet_id" {
  description = "The ID of the subnet to which the MySQL Flexible Server should be connected."
  type        = string
  default     = null
}

# DEPENDENCY: Private DNS Zone must exist
variable "private_dns_zone_id" {
  description = "The ID of the Private DNS Zone to create DNS records."
  type        = string
  default     = null
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for the MySQL Flexible Server."
  type        = bool
  default     = false
}

################################################################################
# Optional Variables - Maintenance
################################################################################

variable "maintenance_window" {
  description = "Maintenance window configuration for the MySQL Flexible Server."
  type = object({
    day_of_week  = number
    start_hour   = number
    start_minute = number
  })
  default = null
}

################################################################################
# Optional Variables - Identity
################################################################################

variable "identity" {
  description = "Managed identity configuration for the MySQL Flexible Server."
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = null

  validation {
    condition     = var.identity == null || contains(["SystemAssigned", "UserAssigned"], var.identity.type)
    error_message = "Identity type must be SystemAssigned or UserAssigned."
  }
}

################################################################################
# Optional Variables - Customer Managed Key
################################################################################

# DEPENDENCY: Key Vault Key must exist
variable "customer_managed_key" {
  description = "Customer managed key configuration for the MySQL Flexible Server."
  type = object({
    key_vault_key_id                     = string
    primary_user_assigned_identity_id    = optional(string)
    geo_backup_key_vault_key_id          = optional(string)
    geo_backup_user_assigned_identity_id = optional(string)
  })
  default = null
}

################################################################################
# Optional Variables - Server Configurations
################################################################################

variable "server_configurations" {
  description = "Map of server configuration parameters."
  type        = map(string)
  default     = {}
}

################################################################################
# Optional Variables - Databases
################################################################################

variable "databases" {
  description = "List of databases to create on the MySQL Flexible Server."
  type = list(object({
    name      = string
    charset   = optional(string, "utf8mb4")
    collation = optional(string, "utf8mb4_unicode_ci")
  }))
  default = []
}

################################################################################
# Optional Variables - Firewall Rules
################################################################################

variable "firewall_rules" {
  description = "List of firewall rules for the MySQL Flexible Server."
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
