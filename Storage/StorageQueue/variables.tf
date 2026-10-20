################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Storage Queue. Set to false to disable resource creation without removing module code."
  type        = bool
  default     = true
}

################################################################################
# Required Variables - Dependencies
################################################################################

variable "storage_account_name" {
  description = <<-EOT
    (Required) The name of the Storage Account where the queue(s) will be created.
    DEPENDENCY: Storage Account must exist before creating the queue.
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
  description = "(Optional) The explicit name for a single Storage Queue. If provided, overrides the generated name from name_prefix. Mutually exclusive with 'queues' variable for naming a single queue."
  type        = string
  default     = null

  validation {
    condition     = var.name == null || can(regex("^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$", var.name))
    error_message = "Queue name must be 3-63 characters, lowercase letters, numbers and hyphens only, must start and end with a letter or number."
  }
}

variable "name_prefix" {
  description = "(Optional) Prefix used for the generated queue name when 'name' is not provided. Default is 'queue'."
  type        = string
  default     = "queue"
}

variable "name_suffix" {
  description = "(Optional) Suffix to append to the generated queue name. Used when 'name' is not provided."
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
# Single Queue Configuration
################################################################################

variable "metadata" {
  description = "(Optional) A mapping of metadata key-value pairs to assign to the single Storage Queue."
  type        = map(string)
  default     = {}
}

################################################################################
# Multiple Queues Configuration
################################################################################

variable "queues" {
  description = <<-EOT
    (Optional) A map of Storage Queues to create using for_each. Each key is the queue name, and the value
    is an object with optional metadata. When this variable is provided, it takes precedence for creating
    multiple queues. The single queue (name/name_prefix) is ignored when this is set.

    Attributes:
      - metadata: (Optional) A mapping of metadata key-value pairs for the queue.

    Example:
      queues = {
        "orders-queue" = {
          metadata = { purpose = "order-processing" }
        }
        "notifications-queue" = {
          metadata = { purpose = "email-notifications" }
        }
      }
  EOT
  type = map(object({
    metadata = optional(map(string), {})
  }))
  default = {}
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A map of tags to assign to resources. These are merged with default module tags."
  type        = map(string)
  default     = {}
}
