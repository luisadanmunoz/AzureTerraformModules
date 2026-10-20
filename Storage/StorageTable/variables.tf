################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Storage Table(s). Set to false to disable resource creation without removing module code."
  type        = bool
  default     = true
}

################################################################################
# Required Variables - Dependencies
################################################################################

variable "storage_account_name" {
  description = <<-EOT
    (Required) The name of the Storage Account where the Table(s) will be created.
    DEPENDENCY: Storage Account must exist before creating Storage Tables.
  EOT
  type        = string

  validation {
    condition     = var.storage_account_name != null && var.storage_account_name != ""
    error_message = "storage_account_name is required and cannot be empty."
  }

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "storage_account_name must be 3-24 characters, lowercase letters and numbers only."
  }
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) The explicit name for the Storage Table. If provided, overrides the name_prefix-based generated name. Ignored when 'tables' is set."
  type        = string
  default     = null

  validation {
    condition     = var.name == null || can(regex("^[a-zA-Z][a-zA-Z0-9]{2,62}$", var.name))
    error_message = "Table name must start with a letter, be 3-63 characters, and contain only alphanumeric characters."
  }
}

variable "name_prefix" {
  description = "(Optional) Prefix to prepend to the generated Storage Table name. Used when 'name' is not provided."
  type        = string
  default     = "table"
}

variable "name_suffix" {
  description = "(Optional) Suffix to append to the generated Storage Table name. Used when 'name' is not provided."
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
# Multiple Tables (for_each)
################################################################################

variable "tables" {
  description = <<-EOT
    (Optional) Map of Storage Tables to create via for_each. When provided, the single-table
    variables (name, acl) are ignored.

    Each key is the table name, and the value is an object with:
      - acl: (Optional) List of access control entries for the table.
        Each ACL entry contains:
          - id: Unique identifier for the ACL entry (up to 64 characters).
          - access_policy: (Optional) Access policy configuration.
            - start: Start time in UTC for the access policy (ISO 8601 format).
            - expiry: Expiry time in UTC for the access policy (ISO 8601 format).
            - permissions: Allowed permissions string (combination of r, a, u, d).
  EOT
  type = map(object({
    acl = optional(list(object({
      id = string
      access_policy = optional(object({
        start       = string
        expiry      = string
        permissions = string
      }), null)
    })), [])
  }))
  default = {}

  validation {
    condition = alltrue([
      for table_name, _ in var.tables :
      can(regex("^[a-zA-Z][a-zA-Z0-9]{2,62}$", table_name))
    ])
    error_message = "Each table name must start with a letter, be 3-63 characters, and contain only alphanumeric characters."
  }
}

################################################################################
# ACL Configuration (Single Table)
################################################################################

variable "acl" {
  description = <<-EOT
    (Optional) List of access control entries for the single Storage Table (used when 'tables' is not set).

    Each ACL entry contains:
      - id: Unique identifier for the ACL entry (up to 64 characters).
      - access_policy: (Optional) Access policy configuration.
        - start: Start time in UTC for the access policy (ISO 8601 format).
        - expiry: Expiry time in UTC for the access policy (ISO 8601 format).
        - permissions: Allowed permissions string (combination of r, a, u, d).
  EOT
  type = list(object({
    id = string
    access_policy = optional(object({
      start       = string
      expiry      = string
      permissions = string
    }), null)
  }))
  default = []

  validation {
    condition = alltrue([
      for entry in var.acl :
      length(entry.id) > 0 && length(entry.id) <= 64
    ])
    error_message = "Each ACL id must be between 1 and 64 characters."
  }
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A map of tags to assign to the resources. These tags are merged with the module's default tags."
  type        = map(string)
  default     = {}
}
