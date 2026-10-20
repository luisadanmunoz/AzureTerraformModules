################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the policy set definition (initiative)."
  type        = string
}

variable "display_name" {
  description = "The display name of the policy set definition."
  type        = string
}

variable "policy_definitions" {
  description = "List of policy definitions to include in the initiative."
  type = list(object({
    policy_definition_id = string
    reference_id         = optional(string)
    parameter_values     = optional(string)
    policy_group_names   = optional(list(string))
  }))
}

################################################################################
# Optional Variables - Configuration
################################################################################

variable "create" {
  description = "Controls whether resources should be created."
  type        = bool
  default     = true
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

variable "description" {
  description = "The description of the policy set definition."
  type        = string
  default     = null
}

variable "metadata" {
  description = "The metadata JSON string for the policy set definition."
  type        = string
  default     = null
}

variable "parameters" {
  description = "The parameters JSON string for the policy set definition."
  type        = string
  default     = null
}

################################################################################
# Optional Variables - Policy Groups
################################################################################

variable "policy_definition_groups" {
  description = "Policy definition groups for organizing policies within the initiative."
  type = list(object({
    name                            = string
    display_name                    = optional(string)
    description                     = optional(string)
    category                        = optional(string)
    additional_metadata_resource_id = optional(string)
  }))
  default = []
}

################################################################################
# Optional Variables - Scope
################################################################################

# DEPENDENCY: Management Group must exist if specified
variable "management_group_id" {
  description = "The ID of the Management Group where this policy set should be defined. If null, will be defined at subscription level."
  type        = string
  default     = null
}
