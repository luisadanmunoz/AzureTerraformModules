#############################################################################
# VARIABLES POLICY EXEMPTION
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

variable "policy_exemption_name" {
  description = "value to set the policy exemption name"
  type        = string

  validation {
    condition     = length(trim(var.policy_exemption_name, " ")) > 0
    error_message = "policy_exemption_name must not be empty."
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

variable "exemption_category" {
  description = "value to set the exemption category"
  type        = string
  default     = "Waiver"
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

variable "expires_on" {
  description = "value to set the expires on"
  type        = string
  default     = null
}

variable "metadata" {
  description = "value to set the metadata"
  type        = any
  default     = null
}

variable "policy_definition_reference_ids" {
  description = "value to set the policy definition reference ids"
  type        = list(string)
  default     = []
}
