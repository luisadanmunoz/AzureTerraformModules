################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Storage Sync resources. Set to false to disable resource creation without removing module code."
  type        = bool
  default     = true
}

################################################################################
# Required Variables - Dependencies
################################################################################

variable "resource_group_name" {
  description = <<-EOT
    (Required) The name of the Resource Group where the Storage Sync will be created.
    DEPENDENCY: Resource Group must exist before creating the Storage Sync.
  EOT
  type        = string

  validation {
    condition     = var.resource_group_name != null && var.resource_group_name != ""
    error_message = "resource_group_name is required and cannot be empty."
  }
}

variable "location" {
  description = <<-EOT
    (Required) The Azure region where the Storage Sync will be deployed.
    DEPENDENCY: Should match the Resource Group location for optimal performance.
  EOT
  type        = string

  validation {
    condition     = var.location != null && var.location != ""
    error_message = "location is required and cannot be empty."
  }
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) The explicit name for the Storage Sync. If provided, overrides name_prefix/workload/environment/instance logic."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix to prepend to the generated Storage Sync name. Used when 'name' is not provided. Default is 'ss'."
  type        = string
  default     = "ss"
}

variable "workload" {
  description = "(Optional) The workload or application name, used for naming convention."
  type        = string
  default     = "shared"
}

variable "environment" {
  description = "(Optional) The environment name (e.g., dev, staging, prod), used for naming convention."
  type        = string
  default     = "dev"
}

variable "instance" {
  description = "(Optional) Instance number or identifier for naming convention."
  type        = string
  default     = "001"
}

################################################################################
# Storage Sync Configuration
################################################################################

variable "incoming_traffic_policy" {
  description = "(Optional) Incoming Traffic Policy for the Storage Sync. Valid options are AllowAllTraffic and AllowVirtualNetworksOnly."
  type        = string
  default     = "AllowAllTraffic"

  validation {
    condition     = contains(["AllowAllTraffic", "AllowVirtualNetworksOnly"], var.incoming_traffic_policy)
    error_message = "incoming_traffic_policy must be either 'AllowAllTraffic' or 'AllowVirtualNetworksOnly'."
  }
}

################################################################################
# Sync Groups
################################################################################

variable "sync_groups" {
  description = <<-EOT
    (Optional) A map of Sync Groups to create within the Storage Sync Service.

    Attributes:
      - name: (Required) The name of the Sync Group.

    Example:
      sync_groups = {
        "sg1" = {
          name = "my-sync-group-1"
        }
        "sg2" = {
          name = "my-sync-group-2"
        }
      }
  EOT
  type = map(object({
    name = string
  }))
  default = {}
}

################################################################################
# Cloud Endpoints
################################################################################

variable "cloud_endpoints" {
  description = <<-EOT
    (Optional) A map of Cloud Endpoints to create for the Sync Groups.
    DEPENDENCY: Storage Account and File Share must exist before creating Cloud Endpoints.

    Attributes:
      - sync_group_key: (Required) The key from sync_groups map to associate this endpoint with.
      - file_share_name: (Required) The name of the Azure File Share to sync.
      - storage_account_id: (Required) The ID of the Storage Account containing the File Share.
      - storage_account_tenant_id: (Optional) The Tenant ID of the Storage Account. Defaults to current tenant.

    Example:
      cloud_endpoints = {
        "ce1" = {
          sync_group_key            = "sg1"
          file_share_name           = "myfileshare"
          storage_account_id        = "/subscriptions/.../storageAccounts/mystorageaccount"
          storage_account_tenant_id = null
        }
      }
  EOT
  type = map(object({
    sync_group_key            = string
    file_share_name           = string
    storage_account_id        = string
    storage_account_tenant_id = optional(string, null)
  }))
  default = {}
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A map of tags to assign to the Storage Sync resources."
  type        = map(string)
  default     = {}
}
