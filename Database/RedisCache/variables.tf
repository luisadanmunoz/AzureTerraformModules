################################################################################
# Required Variables
################################################################################

# DEPENDENCY: Resource Group must exist
variable "resource_group_name" {
  description = "The name of the resource group where the Redis Cache will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the Redis Cache will be created."
  type        = string
}

################################################################################
# Optional Variables - Naming
################################################################################

variable "name" {
  description = "The name of the Redis Cache. If not provided, will be generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix for the Redis Cache name."
  type        = string
  default     = "redis"
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

variable "sku_name" {
  description = "The SKU name for the Redis Cache. Possible values are Basic, Standard, Premium, Enterprise_E10, Enterprise_E20, Enterprise_E50, Enterprise_E100, EnterpriseFlash_F300, EnterpriseFlash_F700, EnterpriseFlash_F1500."
  type        = string
  default     = "Standard"

  validation {
    condition = contains([
      "Basic", "Standard", "Premium",
      "Enterprise_E10", "Enterprise_E20", "Enterprise_E50", "Enterprise_E100",
      "EnterpriseFlash_F300", "EnterpriseFlash_F700", "EnterpriseFlash_F1500"
    ], var.sku_name)
    error_message = "Invalid SKU name."
  }
}

variable "family" {
  description = "The SKU family/pricing group. Valid values are C (Basic/Standard) and P (Premium)."
  type        = string
  default     = "C"

  validation {
    condition     = contains(["C", "P"], var.family)
    error_message = "Family must be C (Basic/Standard) or P (Premium)."
  }
}

variable "capacity" {
  description = "The size of the Redis cache. Valid values for Basic/Standard are 0-6, for Premium are 1-5."
  type        = number
  default     = 1

  validation {
    condition     = var.capacity >= 0 && var.capacity <= 6
    error_message = "Capacity must be between 0 and 6."
  }
}

variable "redis_version" {
  description = "The Redis version. Possible values are 4 and 6."
  type        = string
  default     = "6"

  validation {
    condition     = contains(["4", "6"], var.redis_version)
    error_message = "Redis version must be 4 or 6."
  }
}

################################################################################
# Optional Variables - Security
################################################################################

variable "minimum_tls_version" {
  description = "The minimum TLS version. Possible values are 1.0, 1.1, 1.2."
  type        = string
  default     = "1.2"

  validation {
    condition     = contains(["1.0", "1.1", "1.2"], var.minimum_tls_version)
    error_message = "Minimum TLS version must be 1.0, 1.1, or 1.2."
  }
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for the Redis Cache."
  type        = bool
  default     = true
}

variable "enable_non_ssl_port" {
  description = "Enable the non-SSL port (6379). Not recommended for production."
  type        = bool
  default     = false
}

################################################################################
# Optional Variables - Network (Premium SKU)
################################################################################

# DEPENDENCY: Subnet must exist (Premium SKU only)
variable "subnet_id" {
  description = "The ID of the subnet where the Redis Cache should be deployed (Premium SKU only)."
  type        = string
  default     = null
}

variable "private_static_ip_address" {
  description = "The static IP address to assign to the Redis Cache (Premium SKU only)."
  type        = string
  default     = null
}

################################################################################
# Optional Variables - Clustering (Premium SKU)
################################################################################

variable "shard_count" {
  description = "The number of shards to create on a Premium Cluster Cache (1-10)."
  type        = number
  default     = null

  validation {
    condition     = var.shard_count == null || (var.shard_count >= 1 && var.shard_count <= 10)
    error_message = "Shard count must be between 1 and 10."
  }
}

variable "replicas_per_master" {
  description = "Number of replicas per master for the Redis Cache."
  type        = number
  default     = null
}

variable "replicas_per_primary" {
  description = "Number of replicas per primary for the Redis Cache."
  type        = number
  default     = null
}

################################################################################
# Optional Variables - Availability Zones (Premium SKU)
################################################################################

variable "zones" {
  description = "List of availability zones for the Redis Cache (Premium SKU only)."
  type        = list(string)
  default     = null
}

################################################################################
# Optional Variables - Redis Configuration
################################################################################

variable "redis_configuration" {
  description = "Redis configuration settings."
  type = object({
    aof_backup_enabled                      = optional(bool)
    aof_storage_connection_string_0         = optional(string)
    aof_storage_connection_string_1         = optional(string)
    enable_authentication                   = optional(bool, true)
    active_directory_authentication_enabled = optional(bool)
    maxmemory_reserved                      = optional(number)
    maxmemory_delta                         = optional(number)
    maxmemory_policy                        = optional(string)
    maxfragmentationmemory_reserved         = optional(number)
    rdb_backup_enabled                      = optional(bool)
    rdb_backup_frequency                    = optional(number)
    rdb_backup_max_snapshot_count           = optional(number)
    rdb_storage_connection_string           = optional(string)
    notify_keyspace_events                  = optional(string)
  })
  default = null
}

################################################################################
# Optional Variables - Patch Schedule (Premium SKU)
################################################################################

variable "patch_schedules" {
  description = "List of patch schedules for the Redis Cache (Premium SKU only)."
  type = list(object({
    day_of_week        = string
    start_hour_utc     = optional(number)
    maintenance_window = optional(string)
  }))
  default = []
}

################################################################################
# Optional Variables - Identity
################################################################################

variable "identity" {
  description = "Managed identity configuration for the Redis Cache."
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = null

  validation {
    condition     = var.identity == null || contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity.type)
    error_message = "Identity type must be SystemAssigned, UserAssigned, or 'SystemAssigned, UserAssigned'."
  }
}

################################################################################
# Optional Variables - Firewall Rules
################################################################################

variable "firewall_rules" {
  description = "List of firewall rules for the Redis Cache."
  type = list(object({
    name     = string
    start_ip = string
    end_ip   = string
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
