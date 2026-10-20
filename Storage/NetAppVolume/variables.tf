# -----------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These parameters must be provided.
# -----------------------------------------------------------------------------

variable "resource_group_name" {
  description = "The name of the resource group where the NetApp Volume will be created."
  type        = string
  # DEPENDENCY: Resource group must exist before creating the NetApp Volume
}

variable "location" {
  description = "The Azure region where the NetApp Volume will be created."
  type        = string
}

variable "account_name" {
  description = "The name of the NetApp Account where the volume will be created."
  type        = string
  # DEPENDENCY: NetApp Account must exist before creating the NetApp Volume
}

variable "pool_name" {
  description = "The name of the NetApp Pool where the volume will be created."
  type        = string
  # DEPENDENCY: NetApp Pool must exist before creating the NetApp Volume
}

variable "volume_path" {
  description = "A unique file path for the volume. Used when creating mount targets."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the volume will be created. Must be delegated to Microsoft.NetApp/volumes."
  type        = string
  # DEPENDENCY: Delegated subnet must exist before creating the NetApp Volume
}

variable "storage_quota_in_gb" {
  description = "The maximum storage quota allowed for a file system in Gigabytes. Minimum is 100 GB."
  type        = number

  validation {
    condition     = var.storage_quota_in_gb >= 100
    error_message = "Storage quota must be at least 100 GB."
  }
}

# -----------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# -----------------------------------------------------------------------------

variable "create" {
  description = "Controls whether resources should be created."
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the NetApp Volume. If provided, overrides the generated name."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix to use for the generated name if name is not provided."
  type        = string
  default     = "anfvol"
}

variable "workload" {
  description = "The workload name to include in the generated name."
  type        = string
  default     = null
}

variable "environment" {
  description = "The environment name (e.g., dev, staging, prod) to include in the generated name."
  type        = string
  default     = null
}

variable "instance" {
  description = "The instance identifier to include in the generated name."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to apply to the NetApp Volume."
  type        = map(string)
  default     = {}
}

variable "service_level" {
  description = "The target performance of the file system. Valid values are Standard, Premium, or Ultra."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium", "Ultra"], var.service_level)
    error_message = "Service level must be one of: Standard, Premium, Ultra."
  }
}

variable "protocols" {
  description = "The list of protocols enabled for the volume. Valid values are NFSv3, NFSv4.1, and CIFS."
  type        = list(string)
  default     = ["NFSv3"]

  validation {
    condition     = alltrue([for p in var.protocols : contains(["NFSv3", "NFSv4.1", "CIFS"], p)])
    error_message = "Protocols must be a list containing only: NFSv3, NFSv4.1, CIFS."
  }
}

variable "security_style" {
  description = "Volume security style. Valid values are unix or ntfs."
  type        = string
  default     = "unix"

  validation {
    condition     = contains(["unix", "ntfs"], var.security_style)
    error_message = "Security style must be either unix or ntfs."
  }
}

variable "snapshot_directory_visible" {
  description = "Specifies whether the .snapshot directory is visible."
  type        = bool
  default     = true
}

variable "throughput_in_mibps" {
  description = "Throughput of the volume in MiB/s. Required for manual QoS pools."
  type        = number
  default     = null
}

variable "network_features" {
  description = "Network features for the volume. Valid values are Basic or Standard."
  type        = string
  default     = "Basic"

  validation {
    condition     = contains(["Basic", "Standard"], var.network_features)
    error_message = "Network features must be either Basic or Standard."
  }
}

variable "export_policy_rules" {
  description = "List of export policy rules for the volume."
  type = list(object({
    rule_index                         = number
    allowed_clients                    = string
    protocols_enabled                  = list(string)
    unix_read_only                     = optional(bool, false)
    unix_read_write                    = optional(bool, true)
    root_access_enabled                = optional(bool, true)
    kerberos_5_read_only_enabled       = optional(bool, false)
    kerberos_5_read_write_enabled      = optional(bool, false)
    kerberos_5i_read_only_enabled      = optional(bool, false)
    kerberos_5i_read_write_enabled     = optional(bool, false)
    kerberos_5p_read_only_enabled      = optional(bool, false)
    kerberos_5p_read_write_enabled     = optional(bool, false)
  }))
  default = null
}

variable "data_protection_replication" {
  description = "Data protection replication settings for cross-region replication."
  type = object({
    endpoint_type             = string
    remote_volume_location    = string
    remote_volume_resource_id = string
    replication_frequency     = string
  })
  default = null
}

variable "data_protection_snapshot_policy" {
  description = "Data protection snapshot policy settings."
  type = object({
    snapshot_policy_id = string
  })
  default = null
}

variable "azure_vmware_data_store_enabled" {
  description = "Specifies whether the volume is enabled for Azure VMware Solution datastore purposes."
  type        = bool
  default     = false
}
