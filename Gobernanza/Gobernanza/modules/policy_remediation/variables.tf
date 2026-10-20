#############################################################################
# VARIABLES POLICY REMEDIATION
#############################################################################
variable "remediation_name" {
  description = "value to set the remediation name"
  type        = string

  validation {
    condition     = length(trim(var.remediation_name, " ")) > 0
    error_message = "remediation_name must not be empty."
  }
}

variable "scope_type" {
  description = "value to set the scope type"
  type        = string

  validation {
    condition     = contains(["management_group", "subscription", "resource_group"], var.scope_type)
    error_message = "scope_type must be management_group, subscription, or resource_group."
  }
}

variable "scope_id" {
  description = "value to set the scope id"
  type        = string

  validation {
    condition     = length(trim(var.scope_id, " ")) > 0
    error_message = "scope_id must not be empty."
  }
}

variable "policy_assignment_id" {
  description = "value to set the policy assignment id"
  type        = string

  validation {
    condition     = length(trim(var.policy_assignment_id, " ")) > 0
    error_message = "policy_assignment_id must not be empty."
  }
}

variable "policy_definition_reference_id" {
  description = "value to set the policy definition reference id"
  type        = string
  default     = null
}
