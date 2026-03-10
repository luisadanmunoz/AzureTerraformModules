# -----------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These parameters must be provided
# -----------------------------------------------------------------------------

# DEPENDENCY: This variable expects the name of an existing resource group
# The resource group must be created before this module is applied
# Example: resource_group_name = module.resource_group.name
variable "resource_group_name" {
  description = "The name of the resource group where the Cosmos DB account will be created"
  type        = string
}

variable "location" {
  description = "The Azure region where the Cosmos DB account will be created"
  type        = string
}

# -----------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults
# -----------------------------------------------------------------------------

variable "create" {
  description = "Controls whether resources should be created"
  type        = bool
  default     = true
}

# -----------------------------------------------------------------------------
# NAMING PARAMETERS
# -----------------------------------------------------------------------------

variable "name" {
  description = "The exact name for the Cosmos DB account. If provided, overrides generated name from name_prefix, workload, environment, and instance"
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix for the generated Cosmos DB account name"
  type        = string
  default     = "cosmos"
}

variable "workload" {
  description = "The workload name to include in the generated name"
  type        = string
  default     = null
}

variable "environment" {
  description = "The environment name to include in the generated name (e.g., dev, staging, prod)"
  type        = string
  default     = null
}

variable "instance" {
  description = "The instance identifier to include in the generated name"
  type        = string
  default     = null
}

# -----------------------------------------------------------------------------
# TAGS
# -----------------------------------------------------------------------------

variable "tags" {
  description = "A map of tags to assign to the Cosmos DB account"
  type        = map(string)
  default     = {}
}

# -----------------------------------------------------------------------------
# COSMOS DB CONFIGURATION
# -----------------------------------------------------------------------------

variable "offer_type" {
  description = "The offer type for the Cosmos DB account"
  type        = string
  default     = "Standard"
}

variable "kind" {
  description = "The kind of Cosmos DB account to create"
  type        = string
  default     = "GlobalDocumentDB"

  validation {
    condition     = contains(["GlobalDocumentDB", "MongoDB", "Parse"], var.kind)
    error_message = "The kind must be one of: GlobalDocumentDB, MongoDB, Parse."
  }
}

variable "mongo_server_version" {
  description = "The MongoDB server version. Only applicable when kind is MongoDB"
  type        = string
  default     = null

  validation {
    condition     = var.mongo_server_version == null || contains(["3.2", "3.6", "4.0", "4.2"], var.mongo_server_version)
    error_message = "The mongo_server_version must be one of: 3.2, 3.6, 4.0, 4.2."
  }
}

variable "enable_automatic_failover" {
  description = "Enable automatic failover for the Cosmos DB account"
  type        = bool
  default     = false
}

variable "enable_free_tier" {
  description = "Enable free tier pricing for the Cosmos DB account. Only one free tier account is allowed per subscription"
  type        = bool
  default     = false
}

variable "enable_multiple_write_locations" {
  description = "Enable multiple write locations for the Cosmos DB account"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed for the Cosmos DB account"
  type        = bool
  default     = true
}

variable "is_virtual_network_filter_enabled" {
  description = "Enables virtual network filtering for the Cosmos DB account"
  type        = bool
  default     = false
}

variable "ip_range_filter" {
  description = "Comma-separated list of IP addresses or IP address ranges in CIDR form to allow through the firewall"
  type        = string
  default     = null
}

variable "analytical_storage_enabled" {
  description = "Enable analytical storage capability for the Cosmos DB account"
  type        = bool
  default     = false
}

# -----------------------------------------------------------------------------
# CONSISTENCY POLICY
# -----------------------------------------------------------------------------

variable "consistency_policy" {
  description = "The consistency policy for the Cosmos DB account"
  type = object({
    consistency_level       = string
    max_interval_in_seconds = optional(number)
    max_staleness_prefix    = optional(number)
  })
  default = {
    consistency_level = "Session"
  }

  validation {
    condition     = contains(["BoundedStaleness", "Eventual", "Session", "Strong", "ConsistentPrefix"], var.consistency_policy.consistency_level)
    error_message = "The consistency_level must be one of: BoundedStaleness, Eventual, Session, Strong, ConsistentPrefix."
  }
}

# -----------------------------------------------------------------------------
# GEO LOCATIONS
# -----------------------------------------------------------------------------

variable "geo_locations" {
  description = "List of geo locations for the Cosmos DB account. At least one geo location is required"
  type = list(object({
    location          = string
    failover_priority = number
    zone_redundant    = optional(bool, false)
  }))
  default = null
}

# -----------------------------------------------------------------------------
# CAPABILITIES
# -----------------------------------------------------------------------------

variable "capabilities" {
  description = "List of Cosmos DB capabilities to enable"
  type        = list(string)
  default     = null

  validation {
    condition = var.capabilities == null || alltrue([
      for cap in coalesce(var.capabilities, []) : contains([
        "EnableAggregationPipeline",
        "EnableCassandra",
        "EnableGremlin",
        "EnableMongo",
        "EnableServerless",
        "EnableTable",
        "mongoEnableDocLevelTTL",
        "MongoDBv3.4",
        "DisableRateLimitingResponses"
      ], cap)
    ])
    error_message = "Each capability must be one of: EnableAggregationPipeline, EnableCassandra, EnableGremlin, EnableMongo, EnableServerless, EnableTable, mongoEnableDocLevelTTL, MongoDBv3.4, DisableRateLimitingResponses."
  }
}

# -----------------------------------------------------------------------------
# VIRTUAL NETWORK RULES
# DEPENDENCY: These expect existing virtual network subnet IDs
# The subnets must have Microsoft.AzureCosmosDB service endpoint enabled
# Example: id = module.subnet.id
# -----------------------------------------------------------------------------

variable "virtual_network_rules" {
  description = "List of virtual network rules for the Cosmos DB account"
  type = list(object({
    id                                   = string
    ignore_missing_vnet_service_endpoint = optional(bool, false)
  }))
  default = null
}

# -----------------------------------------------------------------------------
# BACKUP CONFIGURATION
# -----------------------------------------------------------------------------

variable "backup" {
  description = "Backup configuration for the Cosmos DB account"
  type = object({
    type                = string
    interval_in_minutes = optional(number)
    retention_in_hours  = optional(number)
    storage_redundancy  = optional(string)
    tier                = optional(string)
  })
  default = null

  validation {
    condition     = var.backup == null || contains(["Continuous", "Periodic"], var.backup.type)
    error_message = "The backup type must be one of: Continuous, Periodic."
  }
}

# -----------------------------------------------------------------------------
# CORS RULES
# -----------------------------------------------------------------------------

variable "cors_rules" {
  description = "CORS rules configuration for the Cosmos DB account"
  type = object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = optional(number)
  })
  default = null
}

# -----------------------------------------------------------------------------
# IDENTITY
# -----------------------------------------------------------------------------

variable "identity" {
  description = "Identity configuration for the Cosmos DB account"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

# -----------------------------------------------------------------------------
# CUSTOMER MANAGED KEY
# DEPENDENCY: This expects an existing Key Vault Key ID
# The Key Vault must have soft delete and purge protection enabled
# Example: key_vault_key_id = module.key_vault_key.id
# -----------------------------------------------------------------------------

variable "key_vault_key_id" {
  description = "Key Vault Key ID for customer-managed key encryption"
  type        = string
  default     = null
}
