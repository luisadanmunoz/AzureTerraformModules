# ------------------------------------------------------------------------------
# COMMON VARIABLES
# ------------------------------------------------------------------------------

variable "create" {
  description = "Whether to create the Managed Disk resource."
  type        = bool
  default     = true
}

# DEPENDENCY: This variable depends on an Azure Resource Group that must exist.
variable "resource_group_name" {
  description = "The name of the Resource Group where the Managed Disk will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the Managed Disk will be created."
  type        = string
}

# ------------------------------------------------------------------------------
# NAMING VARIABLES
# ------------------------------------------------------------------------------

variable "name" {
  description = "The explicit name for the Managed Disk. If provided, this takes precedence over generated names."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "The prefix to use for the generated Managed Disk name."
  type        = string
  default     = "disk"
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

variable "tags" {
  description = "A map of tags to apply to the Managed Disk resource."
  type        = map(string)
  default     = {}
}

# ------------------------------------------------------------------------------
# MANAGED DISK VARIABLES
# ------------------------------------------------------------------------------

variable "storage_account_type" {
  description = "The type of storage to use for the Managed Disk."
  type        = string

  validation {
    condition = contains([
      "Standard_LRS",
      "StandardSSD_LRS",
      "StandardSSD_ZRS",
      "Premium_LRS",
      "Premium_ZRS",
      "PremiumV2_LRS",
      "UltraSSD_LRS"
    ], var.storage_account_type)
    error_message = "The storage_account_type must be one of: Standard_LRS, StandardSSD_LRS, StandardSSD_ZRS, Premium_LRS, Premium_ZRS, PremiumV2_LRS, UltraSSD_LRS."
  }
}

variable "create_option" {
  description = "The method to use when creating the Managed Disk."
  type        = string
  default     = "Empty"

  validation {
    condition = contains([
      "Empty",
      "Copy",
      "FromImage",
      "Import",
      "ImportSecure",
      "Restore",
      "Upload"
    ], var.create_option)
    error_message = "The create_option must be one of: Empty, Copy, FromImage, Import, ImportSecure, Restore, Upload."
  }
}

variable "disk_size_gb" {
  description = "The size of the Managed Disk in gigabytes."
  type        = number
}

variable "disk_iops_read_write" {
  description = "The number of IOPS allowed for this disk. Only settable for UltraSSD_LRS and PremiumV2_LRS disks."
  type        = number
  default     = null
}

variable "disk_mbps_read_write" {
  description = "The bandwidth allowed for this disk in MB per second. Only settable for UltraSSD_LRS and PremiumV2_LRS disks."
  type        = number
  default     = null
}

variable "disk_iops_read_only" {
  description = "The number of IOPS allowed across all VMs mounting the shared disk as read-only."
  type        = number
  default     = null
}

variable "disk_mbps_read_only" {
  description = "The bandwidth allowed across all VMs mounting the shared disk as read-only in MB per second."
  type        = number
  default     = null
}

# DEPENDENCY: This variable depends on an existing Managed Disk or Snapshot resource for Copy operations.
variable "source_resource_id" {
  description = "The ID of an existing Managed Disk or Snapshot to copy when create_option is Copy or Restore."
  type        = string
  default     = null
}

variable "source_uri" {
  description = "The URI to a valid VHD file to be used when create_option is Import or ImportSecure."
  type        = string
  default     = null
}

# DEPENDENCY: This variable depends on an existing Storage Account for Import operations.
variable "storage_account_id" {
  description = "The ID of the Storage Account where the source_uri is located. Required when create_option is Import or ImportSecure."
  type        = string
  default     = null
}

# DEPENDENCY: This variable depends on an existing Platform Image for FromImage operations.
variable "image_reference_id" {
  description = "The ID of an existing Platform Image to use when create_option is FromImage."
  type        = string
  default     = null
}

# DEPENDENCY: This variable depends on an existing Shared Image Gallery image.
variable "gallery_image_reference_id" {
  description = "The ID of a Gallery Image Version to use when create_option is FromImage."
  type        = string
  default     = null
}

variable "logical_sector_size" {
  description = "The logical sector size in bytes for Ultra disks. Possible values are 512 or 4096."
  type        = number
  default     = null

  validation {
    condition     = var.logical_sector_size == null || contains([512, 4096], var.logical_sector_size)
    error_message = "The logical_sector_size must be either 512 or 4096."
  }
}

variable "os_type" {
  description = "Specify a value when the source of an Import, ImportSecure or Copy operation targets a source that contains an operating system."
  type        = string
  default     = null

  validation {
    condition     = var.os_type == null || contains(["Linux", "Windows"], var.os_type)
    error_message = "The os_type must be either Linux or Windows."
  }
}

variable "tier" {
  description = "The disk performance tier to use. Only applicable to disks of type Premium_LRS."
  type        = string
  default     = null
}

variable "max_shares" {
  description = "The maximum number of VMs that can attach to the disk at the same time. Value greater than 1 indicates a shared disk."
  type        = number
  default     = null
}

variable "zone" {
  description = "The Availability Zone in which the Managed Disk should be located."
  type        = string
  default     = null

  validation {
    condition     = var.zone == null || contains(["1", "2", "3"], var.zone)
    error_message = "The zone must be one of: 1, 2, 3."
  }
}

variable "network_access_policy" {
  description = "The policy for accessing the disk via network."
  type        = string
  default     = "AllowAll"

  validation {
    condition     = contains(["AllowAll", "AllowPrivate", "DenyAll"], var.network_access_policy)
    error_message = "The network_access_policy must be one of: AllowAll, AllowPrivate, DenyAll."
  }
}

# DEPENDENCY: This variable depends on an existing Disk Access resource for private endpoint access.
variable "disk_access_id" {
  description = "The ID of the disk access resource for using private endpoints on disks. Required when network_access_policy is AllowPrivate."
  type        = string
  default     = null
}

variable "public_network_access_enabled" {
  description = "Whether it is allowed to access the disk via public network."
  type        = bool
  default     = true
}

variable "on_demand_bursting_enabled" {
  description = "Specifies if On-Demand Bursting is enabled for the Managed Disk. Only applicable to Premium_LRS, Premium_ZRS, PremiumV2_LRS, and UltraSSD_LRS."
  type        = bool
  default     = false
}

variable "trusted_launch_enabled" {
  description = "Specifies if Trusted Launch is enabled for the Managed Disk."
  type        = bool
  default     = false
}

# DEPENDENCY: This variable depends on an existing Disk Encryption Set for secure VM scenarios.
variable "secure_vm_disk_encryption_set_id" {
  description = "The ID of the Disk Encryption Set which should be used to encrypt this disk when the disk is used with a Confidential VM."
  type        = string
  default     = null
}

variable "security_type" {
  description = "The security type of the Managed Disk when used with Confidential VMs."
  type        = string
  default     = null

  validation {
    condition = var.security_type == null || contains([
      "ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey",
      "ConfidentialVM_DiskEncryptedWithPlatformKey",
      "ConfidentialVM_DiskEncryptedWithCustomerKey"
    ], var.security_type)
    error_message = "The security_type must be one of: ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey, ConfidentialVM_DiskEncryptedWithPlatformKey, ConfidentialVM_DiskEncryptedWithCustomerKey."
  }
}

variable "hyper_v_generation" {
  description = "The Hyper-V Generation of the Disk when the source of an Import or Copy operation targets a source that contains an operating system."
  type        = string
  default     = null

  validation {
    condition     = var.hyper_v_generation == null || contains(["V1", "V2"], var.hyper_v_generation)
    error_message = "The hyper_v_generation must be either V1 or V2."
  }
}

variable "encryption_settings" {
  description = <<-EOT
    Encryption settings for the Managed Disk. Structure:
    {
      disk_encryption_key = {
        secret_url      = string
        source_vault_id = string
      }
      key_encryption_key = {
        key_url         = string
        source_vault_id = string
      }
    }
  EOT
  type = object({
    disk_encryption_key = optional(object({
      secret_url      = string
      source_vault_id = string
    }))
    key_encryption_key = optional(object({
      key_url         = string
      source_vault_id = string
    }))
  })
  default = null
}

# DEPENDENCY: This variable depends on an existing Disk Encryption Set for server-side encryption with CMK.
variable "disk_encryption_set_id" {
  description = "The ID of the Disk Encryption Set which should be used to encrypt this Managed Disk."
  type        = string
  default     = null
}
