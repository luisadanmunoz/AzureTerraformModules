################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the policy assignment."
  type        = string
}

# DEPENDENCY: Policy Definition must exist
variable "policy_definition_id" {
  description = "The ID of the Policy Definition to assign."
  type        = string
}

################################################################################
# Optional Variables - Configuration
################################################################################

variable "create" {
  description = "Controls whether resources should be created."
  type        = bool
  default     = true
}

variable "display_name" {
  description = "The display name of the policy assignment."
  type        = string
  default     = null
}

variable "description" {
  description = "The description of the policy assignment."
  type        = string
  default     = null
}

variable "enforce" {
  description = "Whether the policy assignment is enforced."
  type        = bool
  default     = true
}

variable "parameters" {
  description = "Parameters for the policy assignment in JSON format."
  type        = string
  default     = null
}

variable "metadata" {
  description = "Metadata for the policy assignment in JSON format."
  type        = string
  default     = null
}

################################################################################
# Optional Variables - Scope
################################################################################

variable "scope_type" {
  description = "The type of scope for the assignment: subscription, resource_group, management_group, or resource."
  type        = string
  default     = "subscription"

  validation {
    condition     = contains(["subscription", "resource_group", "management_group", "resource"], var.scope_type)
    error_message = "Scope type must be subscription, resource_group, management_group, or resource."
  }
}

# DEPENDENCY: Resource Group must exist if scope_type is resource_group
variable "resource_group_id" {
  description = "The ID of the Resource Group for the assignment (when scope_type is resource_group)."
  type        = string
  default     = null
}

# DEPENDENCY: Management Group must exist if scope_type is management_group
variable "management_group_id" {
  description = "The ID of the Management Group for the assignment (when scope_type is management_group)."
  type        = string
  default     = null
}

# DEPENDENCY: Subscription must exist if scope_type is subscription
variable "subscription_id" {
  description = "The ID of the Subscription for the assignment (when scope_type is subscription). If null, uses current subscription."
  type        = string
  default     = null
}

variable "resource_id" {
  description = "The ID of the Resource for the assignment (when scope_type is resource)."
  type        = string
  default     = null
}

################################################################################
# Optional Variables - Exclusions
################################################################################

variable "not_scopes" {
  description = "List of resource IDs to exclude from the policy assignment."
  type        = list(string)
  default     = []
}

################################################################################
# Optional Variables - Identity (for remediation)
################################################################################

variable "identity" {
  description = "Managed identity configuration for remediation tasks."
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = null

  validation {
    condition     = var.identity == null || contains(["SystemAssigned", "UserAssigned"], var.identity.type)
    error_message = "Identity type must be SystemAssigned or UserAssigned."
  }
}

variable "location" {
  description = "The location of the policy assignment (required when identity is specified)."
  type        = string
  default     = null
}

################################################################################
# Optional Variables - Non-compliance Messages
################################################################################

variable "non_compliance_messages" {
  description = "List of non-compliance messages for the policy assignment."
  type = list(object({
    content                        = string
    policy_definition_reference_id = optional(string)
  }))
  default = []
}

################################################################################
# Optional Variables - Resource Selectors
################################################################################

variable "resource_selectors" {
  description = "Resource selectors to filter resources for the policy assignment."
  type = list(object({
    name = string
    selectors = list(object({
      kind   = string
      in     = optional(list(string))
      not_in = optional(list(string))
    }))
  }))
  default = []
}

################################################################################
# Optional Variables - Overrides
################################################################################

variable "overrides" {
  description = "Policy property value overrides."
  type = list(object({
    value = string
    selectors = list(object({
      kind   = string
      in     = optional(list(string))
      not_in = optional(list(string))
    }))
  }))
  default = []
}
