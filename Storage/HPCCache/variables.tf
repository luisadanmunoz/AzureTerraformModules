# -----------------------------------------------------------------------------
# CONTROL VARIABLES
# -----------------------------------------------------------------------------

variable "create" {
  description = "Controls whether resources should be created."
  type        = bool
  default     = true
}

# -----------------------------------------------------------------------------
# RESOURCE GROUP AND LOCATION
# -----------------------------------------------------------------------------

# DEPENDENCY: Resource group must exist before creating this resource
variable "resource_group_name" {
  description = "The name of the resource group in which to create the HPC Cache."
  type        = string
}

variable "location" {
  description = "The Azure region where the HPC Cache should be created."
  type        = string
}

# -----------------------------------------------------------------------------
# NAMING VARIABLES
# -----------------------------------------------------------------------------

variable "name" {
  description = "The name of the HPC Cache. If provided, overrides the generated name."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix for the generated HPC Cache name."
  type        = string
  default     = "hpc"
}

variable "workload" {
  description = "The workload name for the HPC Cache."
  type        = string
  default     = null
}

variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)."
  type        = string
  default     = null
}

variable "instance" {
  description = "The instance identifier for the HPC Cache."
  type        = string
  default     = null
}

# -----------------------------------------------------------------------------
# TAGS
# -----------------------------------------------------------------------------

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

# -----------------------------------------------------------------------------
# HPC CACHE CONFIGURATION
# -----------------------------------------------------------------------------

variable "cache_size_in_gb" {
  description = "The size of the HPC Cache in GB. Valid values are: 3072, 6144, 12288, 21623, 24576, 43246, 49152, or 86491."
  type        = number

  validation {
    condition     = contains([3072, 6144, 12288, 21623, 24576, 43246, 49152, 86491], var.cache_size_in_gb)
    error_message = "The cache_size_in_gb must be one of: 3072, 6144, 12288, 21623, 24576, 43246, 49152, or 86491."
  }
}

variable "sku_name" {
  description = "The SKU of the HPC Cache. Valid values are: Standard_2G, Standard_4G, Standard_8G, Standard_L4_5G, Standard_L9G, or Standard_L16G."
  type        = string

  validation {
    condition     = contains(["Standard_2G", "Standard_4G", "Standard_8G", "Standard_L4_5G", "Standard_L9G", "Standard_L16G"], var.sku_name)
    error_message = "The sku_name must be one of: Standard_2G, Standard_4G, Standard_8G, Standard_L4_5G, Standard_L9G, or Standard_L16G."
  }
}

# DEPENDENCY: Subnet must exist before creating this resource
# DEPENDENCY: Subnet must have Microsoft.StorageCache service endpoint enabled
variable "subnet_id" {
  description = "The ID of the subnet where the HPC Cache will be deployed. The subnet must have the Microsoft.StorageCache service endpoint enabled."
  type        = string
}

variable "mtu" {
  description = "The MTU setting for the HPC Cache. Valid range is 576-1500."
  type        = number
  default     = 1500

  validation {
    condition     = var.mtu >= 576 && var.mtu <= 1500
    error_message = "The mtu must be between 576 and 1500."
  }
}

variable "ntp_server" {
  description = "The NTP server IP address or FQDN for the HPC Cache."
  type        = string
  default     = "time.windows.com"
}

# -----------------------------------------------------------------------------
# DNS CONFIGURATION
# -----------------------------------------------------------------------------

variable "dns" {
  description = "DNS configuration for the HPC Cache."
  type = object({
    servers       = list(string)
    search_domain = optional(string)
  })
  default = null
}

# -----------------------------------------------------------------------------
# DEFAULT ACCESS POLICY
# -----------------------------------------------------------------------------

variable "default_access_policy" {
  description = "The default access policy for the HPC Cache with access rules."
  type = list(object({
    scope                   = string
    access                  = string
    anonymous_uid           = optional(number)
    anonymous_gid           = optional(number)
    filter                  = optional(string)
    root_squash_enabled     = optional(bool)
    submount_access_enabled = optional(bool)
    suid_enabled            = optional(bool)
  }))
  default = null

  validation {
    condition = var.default_access_policy == null || alltrue([
      for rule in coalesce(var.default_access_policy, []) : contains(["default", "network", "host"], rule.scope)
    ])
    error_message = "Each access rule scope must be one of: default, network, or host."
  }

  validation {
    condition = var.default_access_policy == null || alltrue([
      for rule in coalesce(var.default_access_policy, []) : contains(["rw", "ro", "no"], rule.access)
    ])
    error_message = "Each access rule access must be one of: rw, ro, or no."
  }
}

# -----------------------------------------------------------------------------
# IDENTITY CONFIGURATION
# -----------------------------------------------------------------------------

variable "identity" {
  description = "Managed identity configuration for the HPC Cache."
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null

  validation {
    condition = var.identity == null || contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], try(var.identity.type, ""))
    error_message = "The identity type must be one of: SystemAssigned, UserAssigned, or 'SystemAssigned, UserAssigned'."
  }
}

# -----------------------------------------------------------------------------
# ENCRYPTION CONFIGURATION
# -----------------------------------------------------------------------------

# DEPENDENCY: Key Vault key must exist before using this variable
variable "key_vault_key_id" {
  description = "The ID of the Key Vault Key to use for customer-managed key encryption."
  type        = string
  default     = null
}

variable "automatically_rotate_key_to_latest_enabled" {
  description = "Whether to automatically rotate the customer-managed key to the latest version."
  type        = bool
  default     = false
}

# -----------------------------------------------------------------------------
# DIRECTORY SERVICE CONFIGURATION
# -----------------------------------------------------------------------------

variable "directory_active_directory" {
  description = "Active Directory configuration for the HPC Cache."
  type = object({
    dns_primary_ip      = string
    domain_name         = string
    cache_netbios_name  = string
    domain_netbios_name = string
    username            = string
    password            = string
    dns_secondary_ip    = optional(string)
  })
  default   = null
  sensitive = true
}

variable "directory_flat_file" {
  description = "Flat file directory configuration for the HPC Cache."
  type = object({
    group_file_uri    = string
    password_file_uri = string
  })
  default = null
}

variable "directory_ldap" {
  description = "LDAP directory configuration for the HPC Cache."
  type = object({
    server                             = string
    base_dn                            = string
    encrypted                          = optional(bool)
    certificate_validation_uri         = optional(string)
    download_certificate_automatically = optional(bool)
    bind = optional(object({
      dn       = string
      password = string
    }))
  })
  default   = null
  sensitive = true
}
