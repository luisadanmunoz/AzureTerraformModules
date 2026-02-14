################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the policy definition."
  type        = string
}

variable "policy_type" {
  description = "The policy type. Possible values are BuiltIn, Custom, NotSpecified, Static."
  type        = string
  default     = "Custom"

  validation {
    condition     = contains(["BuiltIn", "Custom", "NotSpecified", "Static"], var.policy_type)
    error_message = "Policy type must be BuiltIn, Custom, NotSpecified, or Static."
  }
}

variable "mode" {
  description = "The policy mode. Possible values are All, Indexed, Microsoft.ContainerService.Data, etc."
  type        = string
  default     = "All"
}

variable "display_name" {
  description = "The display name of the policy definition."
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

variable "description" {
  description = "The description of the policy definition."
  type        = string
  default     = null
}

variable "policy_rule" {
  description = "The policy rule JSON string."
  type        = string
  default     = null
}

variable "policy_rule_file" {
  description = "Path to a file containing the policy rule JSON."
  type        = string
  default     = null
}

variable "metadata" {
  description = "The metadata JSON string for the policy definition."
  type        = string
  default     = null
}

variable "parameters" {
  description = "The parameters JSON string for the policy definition."
  type        = string
  default     = null
}

################################################################################
# Optional Variables - Scope
################################################################################

# DEPENDENCY: Management Group must exist if specified
variable "management_group_id" {
  description = "The ID of the Management Group where this policy should be defined. If null, will be defined at subscription level."
  type        = string
  default     = null
}
