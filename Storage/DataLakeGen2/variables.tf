################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Data Lake Gen2 Filesystem. Set to false to disable resource creation without removing module code."
  type        = bool
  default     = true
}

################################################################################
# Required Variables - Dependencies
################################################################################

variable "storage_account_id" {
  description = <<-EOT
    (Required) The ID of the Storage Account where the Data Lake Gen2 Filesystem will be created.
    DEPENDENCY: Storage Account with is_hns_enabled=true must exist before creating this resource.
  EOT
  type        = string

  validation {
    condition     = var.storage_account_id != null && var.storage_account_id != ""
    error_message = "storage_account_id is required and cannot be empty."
  }
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) The explicit name for the Data Lake Gen2 Filesystem. If provided, overrides name_prefix/name_suffix logic."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix to prepend to the generated Filesystem name. Used when 'name' is not provided."
  type        = string
  default     = "dlfs"
}

variable "name_suffix" {
  description = "(Optional) Suffix to append to the generated Filesystem name. Used when 'name' is not provided."
  type        = string
  default     = ""
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
# Filesystem Configuration
################################################################################

variable "properties" {
  description = "(Optional) A map of custom properties to associate with the Data Lake Gen2 Filesystem."
  type        = map(string)
  default     = {}
}

variable "owner" {
  description = "(Optional) The Azure Active Directory object ID of the owner of the Filesystem."
  type        = string
  default     = null
}

variable "group" {
  description = "(Optional) The Azure Active Directory object ID of the owning group of the Filesystem."
  type        = string
  default     = null
}

################################################################################
# ACL Configuration
################################################################################

variable "ace" {
  description = <<-EOT
    (Optional) List of Access Control Entries (ACL) for the Data Lake Gen2 Filesystem.

    Attributes:
      - scope:       (Optional) The scope of the ACE. Possible values: "access", "default". Defaults to "access".
      - type:        (Required) The type of the ACE. Possible values: "user", "group", "mask", "other".
      - id:          (Optional) The Azure Active Directory object ID for the user or group. Required when type is "user" or "group".
      - permissions: (Required) The permissions string (e.g., "rwx", "r-x", "---").
  EOT
  type = list(object({
    scope       = optional(string, "access")
    type        = string
    id          = optional(string, null)
    permissions = string
  }))
  default = []

  validation {
    condition = alltrue([
      for ace in var.ace : contains(["user", "group", "mask", "other"], ace.type)
    ])
    error_message = "Each ace.type must be one of: 'user', 'group', 'mask', 'other'."
  }

  validation {
    condition = alltrue([
      for ace in var.ace : contains(["access", "default"], ace.scope)
    ])
    error_message = "Each ace.scope must be one of: 'access', 'default'."
  }
}

################################################################################
# Paths (Directories)
################################################################################

variable "paths" {
  description = <<-EOT
    (Optional) Map of paths (directories) to create within the Data Lake Gen2 Filesystem.
    DEPENDENCY: The Data Lake Gen2 Filesystem must be created before paths can be added.

    Attributes:
      - path:     (Required) The path to create within the filesystem.
      - resource: (Optional) The type of resource. Defaults to "directory".
      - owner:    (Optional) The Azure Active Directory object ID of the owner.
      - group:    (Optional) The Azure Active Directory object ID of the owning group.
      - ace:      (Optional) List of ACL entries for this path.
  EOT
  type = map(object({
    path     = string
    resource = optional(string, "directory")
    owner    = optional(string, null)
    group    = optional(string, null)
    ace = optional(list(object({
      scope       = optional(string, "access")
      type        = string
      id          = optional(string, null)
      permissions = string
    })), [])
  }))
  default = {}
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A map of tags to assign to the resources. These are merged with default module tags."
  type        = map(string)
  default     = {}
}
