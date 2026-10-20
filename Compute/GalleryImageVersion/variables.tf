################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Gallery Image Version."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Version should exist."
  type        = string
}

variable "gallery_name" {
  description = "(Required) The name of the Shared Image Gallery. DEPENDENCY: Gallery must exist."
  type        = string
}

variable "image_name" {
  description = "(Required) The name of the Gallery Image Definition. DEPENDENCY: Image Definition must exist."
  type        = string
}

################################################################################
# Version Configuration
################################################################################

variable "name" {
  description = "(Required) The version number in semantic versioning format (e.g., 1.0.0)."
  type        = string
}

variable "managed_image_id" {
  description = "(Optional) The ID of the Managed Image to use. DEPENDENCY: Managed Image must exist."
  type        = string
  default     = null
}

variable "os_disk_snapshot_id" {
  description = "(Optional) The ID of the OS Disk Snapshot to use. DEPENDENCY: Snapshot must exist."
  type        = string
  default     = null
}

variable "blob_uri" {
  description = "(Optional) The URI of a blob to use as source."
  type        = string
  default     = null
}

variable "storage_account_id" {
  description = "(Optional) The Storage Account ID for blob source. DEPENDENCY: Storage Account must exist."
  type        = string
  default     = null
}

variable "exclude_from_latest" {
  description = "(Optional) Exclude this version from being considered latest. Default: false."
  type        = bool
  default     = false
}

variable "end_of_life_date" {
  description = "(Optional) The end of life date in RFC3339 format."
  type        = string
  default     = null
}

variable "replication_mode" {
  description = "(Optional) Replication mode. Values: Full, Shallow. Default: Full."
  type        = string
  default     = "Full"
}

################################################################################
# Target Regions
################################################################################

variable "target_regions" {
  description = <<-EOT
    (Required) List of target regions for replication.
    - name: Region name.
    - regional_replica_count: Number of replicas. Default: 1.
    - storage_account_type: Storage type. Default: Standard_LRS.
    - disk_encryption_set_id: DES ID for encryption.
    - exclude_from_latest_enabled: Exclude from latest in this region.
  EOT
  type = list(object({
    name                         = string
    regional_replica_count       = optional(number, 1)
    storage_account_type         = optional(string, "Standard_LRS")
    disk_encryption_set_id       = optional(string, null)
    exclude_from_latest_enabled  = optional(bool, false)
  }))
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
