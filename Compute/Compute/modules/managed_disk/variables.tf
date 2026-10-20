#############################################################################
# VARIABLES MANAGED DISK
#############################################################################
variable "managed_disk_name" {
  description = "value to set the managed disk name"
  type        = string
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "location" {
  description = "value to set the location"
  type        = string
}

variable "create_option" {
  description = "value to set the create option"
  type        = string
}

variable "storage_account_type" {
  description = "value to set the storage account type"
  type        = string
}

variable "disk_access_id" {
  description = "value to set the disk access id"
  type        = string
  default     = null
}

variable "disk_encryption_set_id" {
  description = "value to set the disk encryption set id"
  type        = string
  default     = null
}

variable "disk_iops_read_only" {
  description = "value to set the disk iops read only"
  type        = number
  default     = null
}

variable "disk_iops_read_write" {
  description = "value to set the disk iops read write"
  type        = number
  default     = null
}

variable "disk_mbps_read_only" {
  description = "value to set the disk mbps read only"
  type        = number
  default     = null
}

variable "disk_mbps_read_write" {
  description = "value to set the disk mbps read write"
  type        = number
  default     = null
}

variable "disk_size_gb" {
  description = "value to set the disk size gb"
  type        = number
  default     = null
}

variable "edge_zone" {
  description = "value to set the edge zone"
  type        = string
  default     = null
}

variable "gallery_image_reference_id" {
  description = "value to set the gallery image reference id"
  type        = string
  default     = null
}

variable "hyper_v_generation" {
  description = "value to set the hyper v generation"
  type        = string
  default     = null
}

variable "image_reference_id" {
  description = "value to set the image reference id"
  type        = string
  default     = null
}

variable "logical_sector_size" {
  description = "value to set the logical sector size"
  type        = number
  default     = null
}

variable "max_shares" {
  description = "value to set the max shares"
  type        = number
  default     = null
}

variable "network_access_policy" {
  description = "value to set the network access policy"
  type        = string
  default     = null
}

variable "on_demand_bursting_enabled" {
  description = "value to set the on demand bursting enabled"
  type        = bool
  default     = null
}

variable "optimized_frequent_attach_enabled" {
  description = "value to set the optimized frequent attach enabled"
  type        = bool
  default     = null
}

variable "os_type" {
  description = "value to set the os type"
  type        = string
  default     = null
}

variable "performance_plus_enabled" {
  description = "value to set the performance plus enabled"
  type        = bool
  default     = null
}

variable "public_network_access_enabled" {
  description = "value to set the public network access enabled"
  type        = bool
  default     = null
}

variable "secure_vm_disk_encryption_set_id" {
  description = "value to set the secure vm disk encryption set id"
  type        = string
  default     = null
}

variable "security_type" {
  description = "value to set the security type"
  type        = string
  default     = null
}

variable "source_resource_id" {
  description = "value to set the source resource id"
  type        = string
  default     = null
}

variable "source_uri" {
  description = "value to set the source uri"
  type        = string
  default     = null
}

variable "storage_account_id" {
  description = "value to set the storage account id"
  type        = string
  default     = null
}

variable "trusted_launch_enabled" {
  description = "value to set the trusted launch enabled"
  type        = bool
  default     = null
}

variable "upload_size_bytes" {
  description = "value to set the upload size bytes"
  type        = number
  default     = null
}

variable "zone" {
  description = "value to set the zone"
  type        = string
  default     = null
}

variable "encryption_settings" {
  description = "value to set the encryption settings"
  type = object({
    disk_encryption_key = object({
      secret_url      = string
      source_vault_id = string
    })
    key_encryption_key = optional(object({
      key_url         = string
      source_vault_id = string
    }))
  })
  default = null
}

variable "timeouts" {
  description = "value to set the timeouts"
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
