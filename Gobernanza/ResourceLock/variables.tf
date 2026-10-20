################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the resource lock."
  type        = string
}

variable "lock_level" {
  description = "The lock level. Possible values are CanNotDelete and ReadOnly."
  type        = string

  validation {
    condition     = contains(["CanNotDelete", "ReadOnly"], var.lock_level)
    error_message = "Lock level must be CanNotDelete or ReadOnly."
  }
}

################################################################################
# Optional Variables - Configuration
################################################################################

variable "create" {
  description = "Controls whether resources should be created."
  type        = bool
  default     = true
}

variable "notes" {
  description = "Notes about the lock."
  type        = string
  default     = null
}

################################################################################
# Optional Variables - Scope
################################################################################

variable "scope_type" {
  description = "The type of scope for the lock: resource_group, resource, or subscription."
  type        = string
  default     = "resource_group"

  validation {
    condition     = contains(["resource_group", "resource", "subscription"], var.scope_type)
    error_message = "Scope type must be resource_group, resource, or subscription."
  }
}

# DEPENDENCY: Resource Group must exist if scope_type is resource_group
variable "resource_group_name" {
  description = "The name of the Resource Group for the lock (when scope_type is resource_group)."
  type        = string
  default     = null
}

# DEPENDENCY: Resource must exist if scope_type is resource
variable "scope" {
  description = "The scope at which the lock should be created (for resource scope)."
  type        = string
  default     = null
}

# DEPENDENCY: Subscription must exist if scope_type is subscription
variable "subscription_id" {
  description = "The ID of the Subscription for the lock (when scope_type is subscription)."
  type        = string
  default     = null
}
