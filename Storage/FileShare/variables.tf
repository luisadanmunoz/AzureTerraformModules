################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the File Share. Set to false to disable resource creation without removing module code."
  type        = bool
  default     = true
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) The explicit name for the File Share. If provided, overrides the generated name from name_prefix."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix used to generate the File Share name when 'name' is not provided."
  type        = string
  default     = "share"
}

variable "name_suffix" {
  description = "(Optional) Suffix to append to the generated File Share name. Used when 'name' is not provided."
  type        = string
  default     = ""
}

################################################################################
# Required Variables - Dependencies
################################################################################

variable "storage_account_id" {
  description = <<-EOT
    (Required) The ID of the Storage Account in which to create the File Share.
    DEPENDENCY: Storage Account must exist before creating the File Share.
  EOT
  type        = string

  validation {
    condition     = var.storage_account_id != null && var.storage_account_id != ""
    error_message = "storage_account_id is required and cannot be empty."
  }
}

variable "quota" {
  description = <<-EOT
    (Required) The maximum size of the File Share in GB.
    For SMB shares: 1-102400 GB (100 TiB).
    For Premium file shares the minimum is 100 GB.
  EOT
  type        = number

  validation {
    condition     = var.quota >= 1 && var.quota <= 102400
    error_message = "quota must be between 1 and 102400 GB."
  }
}

################################################################################
# Optional Variables
################################################################################

variable "access_tier" {
  description = "(Optional) The access tier of the File Share. Possible values are Hot, Cool, TransactionOptimized, and Premium."
  type        = string
  default     = "TransactionOptimized"

  validation {
    condition     = contains(["Hot", "Cool", "TransactionOptimized", "Premium"], var.access_tier)
    error_message = "access_tier must be one of: Hot, Cool, TransactionOptimized, Premium."
  }
}

variable "enabled_protocol" {
  description = "(Optional) The protocol used for the File Share. Possible values are SMB and NFS."
  type        = string
  default     = "SMB"

  validation {
    condition     = contains(["SMB", "NFS"], var.enabled_protocol)
    error_message = "enabled_protocol must be either 'SMB' or 'NFS'."
  }
}

variable "metadata" {
  description = "(Optional) A mapping of metadata to assign to the File Share."
  type        = map(string)
  default     = null
}

variable "acl" {
  description = <<-EOT
    (Optional) List of access control list (ACL) entries for the File Share.
    Each entry specifies an ACL policy with permissions.

    Attributes:
      - id: A unique identifier for the ACL entry.
      - access_policy: (Optional) Access policy configuration block.
        - start:       (Optional) The start time of the access policy in ISO 8601 format.
        - expiry:      (Optional) The expiry time of the access policy in ISO 8601 format.
        - permissions: (Required) The permissions granted by the access policy (r, w, d, l combinations).
  EOT
  type = list(object({
    id = string
    access_policy = optional(object({
      start       = optional(string)
      expiry      = optional(string)
      permissions = string
    }))
  }))
  default = []
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A map of tags to assign to the File Share. These tags are merged with the default tags."
  type        = map(string)
  default     = {}
}
