################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Blob Container. Set to false to disable resource creation without removing module code."
  type        = bool
  default     = true
}

################################################################################
# Required Variables - Dependencies
################################################################################

variable "storage_account_id" {
  description = <<-EOT
    (Required) The ID of the Storage Account where the Blob Container will be created.
    DEPENDENCY: Storage Account must exist before creating the Blob Container.
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
  description = "(Optional) The explicit name for the Blob Container. If provided, overrides name_prefix/name_suffix logic."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix to prepend to the generated Blob Container name. Used when 'name' is not provided."
  type        = string
  default     = "blob"
}

variable "name_suffix" {
  description = "(Optional) Suffix to append to the generated Blob Container name. Used when 'name' is not provided."
  type        = string
  default     = ""
}

variable "workload" {
  description = "(Optional) The workload or purpose name, used for naming convention."
  type        = string
  default     = "default"
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
# Blob Container Configuration
################################################################################

variable "container_access_type" {
  description = <<-EOT
    (Optional) The access level configured for the Blob Container.
    Possible values: "blob", "container", "private". Defaults to "private".
    - "private":   No anonymous access. All requests must be authorized.
    - "blob":      Anonymous read access for blobs only.
    - "container": Anonymous read access for the container and its blobs.
  EOT
  type        = string
  default     = "private"

  validation {
    condition     = contains(["blob", "container", "private"], var.container_access_type)
    error_message = "container_access_type must be one of: blob, container, private."
  }
}

variable "metadata" {
  description = "(Optional) A mapping of metadata key-value pairs to assign to the Blob Container."
  type        = map(string)
  default     = null
}

variable "default_encryption_scope" {
  description = <<-EOT
    (Optional) The default encryption scope to use for blobs uploaded to this container.
    DEPENDENCY: The encryption scope must exist on the Storage Account before referencing.
  EOT
  type        = string
  default     = null
}

variable "encryption_scope_override_enabled" {
  description = "(Optional) Whether to allow blobs to override the default encryption scope. Defaults to true."
  type        = bool
  default     = true
}

################################################################################
# Immutability Policy
################################################################################

variable "immutability_policy" {
  description = <<-EOT
    (Optional) Immutability policy configuration for the Blob Container.
    When configured, blobs in the container cannot be modified or deleted for the specified period.

    Attributes:
      - expiry_in_days: (Required) The number of days that blobs are immutable.
      - policy_mode:    (Required) The immutability policy mode. Possible values: "Unlocked", "Locked".
                        WARNING: Once set to "Locked", the policy cannot be reversed or removed.
  EOT
  type = object({
    expiry_in_days = number
    policy_mode    = string
  })
  default = null

  validation {
    condition     = var.immutability_policy == null || contains(["Unlocked", "Locked"], try(var.immutability_policy.policy_mode, "Unlocked"))
    error_message = "immutability_policy.policy_mode must be one of: Unlocked, Locked."
  }

  validation {
    condition     = var.immutability_policy == null || try(var.immutability_policy.expiry_in_days, 1) > 0
    error_message = "immutability_policy.expiry_in_days must be greater than 0."
  }
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to resources that support tagging."
  type        = map(string)
  default     = {}
}
