#############################################################################
# VARIABLES POLICY ASSIGNMENT
#############################################################################
variable "scope_type" {
  description = "value to set the scope type"
  type        = string

  validation {
    condition     = contains(["management_group", "subscription", "resource_group", "resource"], var.scope_type)
    error_message = "scope_type must be management_group, subscription, resource_group, or resource."
  }
}

variable "scope_id" {
  description = "value to set the scope id"
  type        = string
}

variable "policy_assignment_name" {
  description = "value to set the policy assignment name"
  type        = string

  validation {
    condition     = length(trim(var.policy_assignment_name, " ")) > 0
    error_message = "policy_assignment_name must not be empty."
  }
}

variable "display_name" {
  description = "value to set the display name"
  type        = string
  default     = null
}

variable "description" {
  description = "value to set the description"
  type        = string
  default     = null
}

variable "policy_definition_id" {
  description = "value to set the policy definition id"
  type        = string

  validation {
    condition     = length(trim(var.policy_definition_id, " ")) > 0
    error_message = "policy_definition_id must not be empty."
  }
}

variable "parameters" {
  description = "value to set the parameters"
  type        = any
  default     = null
}

variable "location" {
  description = "value to set the location"
  type        = string
  default     = null

  validation {
    condition     = var.identity_type == null || (var.location != null && length(trim(var.location, " ")) > 0)
    error_message = "location must be provided when identity_type is set."
  }
}

variable "identity_type" {
  description = "value to set the identity type"
  type        = string
  default     = null

  validation {
    condition     = var.identity_type == null || contains(["SystemAssigned", "UserAssigned"], var.identity_type)
    error_message = "identity_type must be null, SystemAssigned, or UserAssigned."
  }
}

variable "identity_ids" {
  description = "value to set the identity ids"
  type        = list(string)
  default     = []

  validation {
    condition = (
      var.identity_type != "UserAssigned" || length(var.identity_ids) > 0
      ) && (
      var.identity_type != "SystemAssigned" || length(var.identity_ids) == 0
    )
    error_message = "identity_ids must be provided for UserAssigned identities and omitted for SystemAssigned."
  }
}

variable "not_scopes" {
  description = "value to set the not scopes"
  type        = list(string)
  default     = []
}

variable "enforce" {
  description = "value to set the enforce"
  type        = bool
  default     = true
}

variable "metadata" {
  description = "value to set the metadata"
  type        = any
  default     = null
}
