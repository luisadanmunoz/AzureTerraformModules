################################################################################
# Common Variables
################################################################################

variable "create" {
  description = "Controls whether resources should be created."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Elastic SAN. DEPENDENCY: Must be an existing resource group."
  type        = string
}

variable "location" {
  description = "The Azure region where the Elastic SAN will be created."
  type        = string
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "The name of the Elastic SAN. If provided, overrides the generated name."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "The prefix to use for the generated Elastic SAN name."
  type        = string
  default     = "esan"
}

variable "workload" {
  description = "The workload name to include in the generated name."
  type        = string
  default     = null
}

variable "environment" {
  description = "The environment name to include in the generated name (e.g., dev, staging, prod)."
  type        = string
  default     = null
}

variable "instance" {
  description = "The instance identifier to include in the generated name."
  type        = string
  default     = null
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

################################################################################
# Elastic SAN Configuration
################################################################################

variable "sku" {
  description = "The SKU configuration for the Elastic SAN."
  type = object({
    name = string           # Premium_LRS or Premium_ZRS
    tier = optional(string) # Optional tier specification
  })

  validation {
    condition     = contains(["Premium_LRS", "Premium_ZRS"], var.sku.name)
    error_message = "The SKU name must be either 'Premium_LRS' or 'Premium_ZRS'."
  }
}

variable "base_size_in_tib" {
  description = "The base size of the Elastic SAN in TiB. Must be between 1 and 100."
  type        = number

  validation {
    condition     = var.base_size_in_tib >= 1 && var.base_size_in_tib <= 100
    error_message = "The base_size_in_tib must be between 1 and 100."
  }
}

variable "extended_size_in_tib" {
  description = "The extended size of the Elastic SAN in TiB. Default is 0."
  type        = number
  default     = 0

  validation {
    condition     = var.extended_size_in_tib >= 0
    error_message = "The extended_size_in_tib must be 0 or greater."
  }
}

variable "zones" {
  description = "The availability zones for the Elastic SAN. Valid values are '1', '2', or '3'."
  type        = list(string)
  default     = null

  validation {
    condition     = var.zones == null || alltrue([for z in coalesce(var.zones, []) : contains(["1", "2", "3"], z)])
    error_message = "Valid zone values are '1', '2', or '3'."
  }
}

################################################################################
# Volume Groups Configuration
################################################################################

variable "volume_groups" {
  description = <<-EOT
    A map of volume groups to create within the Elastic SAN.

    Each volume group object supports:
    - name: The name of the volume group
    - encryption_type: The encryption type (EncryptionAtRestWithPlatformKey or EncryptionAtRestWithCustomerManagedKey)
    - encryption: Optional encryption configuration for customer-managed keys
      - key_vault_key_id: The Key Vault Key URI. DEPENDENCY: Must be an existing Key Vault key.
      - user_assigned_identity_id: The User Assigned Identity ID. DEPENDENCY: Must be an existing User Assigned Identity.
    - network_rules: Optional network rules configuration
      - virtual_network_rules: List of virtual network rules
        - subnet_id: The subnet ID. DEPENDENCY: Must be an existing subnet.
        - action: The action (Allow)
    - protocol_type: The protocol type (Iscsi or None)
  EOT
  type = map(object({
    name            = string
    encryption_type = optional(string, "EncryptionAtRestWithPlatformKey")
    encryption = optional(object({
      key_vault_key_id          = string
      user_assigned_identity_id = optional(string)
    }))
    network_rules = optional(object({
      virtual_network_rules = optional(list(object({
        subnet_id = string
        action    = optional(string, "Allow")
      })), [])
    }))
    protocol_type = optional(string, "Iscsi")
  }))
  default = {}

  validation {
    condition = alltrue([
      for k, v in var.volume_groups :
      contains(["EncryptionAtRestWithPlatformKey", "EncryptionAtRestWithCustomerManagedKey"], v.encryption_type)
    ])
    error_message = "The encryption_type must be either 'EncryptionAtRestWithPlatformKey' or 'EncryptionAtRestWithCustomerManagedKey'."
  }

  validation {
    condition = alltrue([
      for k, v in var.volume_groups :
      contains(["Iscsi", "None"], v.protocol_type)
    ])
    error_message = "The protocol_type must be either 'Iscsi' or 'None'."
  }
}

################################################################################
# Volumes Configuration
################################################################################

variable "volumes" {
  description = <<-EOT
    A map of volumes to create within volume groups.

    Each volume object supports:
    - volume_group_key: The key of the volume group to create this volume in
    - name: The name of the volume
    - size_in_gib: The size of the volume in GiB
    - create_source: Optional source configuration for the volume
      - source_id: The source ID. DEPENDENCY: Must be an existing snapshot or volume.
      - source_type: The source type (Disk, DiskRestorePoint, DiskSnapshot, VolumeSnapshot)
  EOT
  type = map(object({
    volume_group_key = string
    name             = string
    size_in_gib      = number
    create_source = optional(object({
      source_id   = string
      source_type = string
    }))
  }))
  default = {}

  validation {
    condition = alltrue([
      for k, v in var.volumes :
      v.create_source == null || contains(["Disk", "DiskRestorePoint", "DiskSnapshot", "VolumeSnapshot"], v.create_source.source_type)
    ])
    error_message = "The source_type must be one of 'Disk', 'DiskRestorePoint', 'DiskSnapshot', or 'VolumeSnapshot'."
  }
}
