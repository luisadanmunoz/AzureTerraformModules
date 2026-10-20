#############################################################################
# VARIABLES POLICY SET DEFINITION
#############################################################################
variable "policy_set_definition_name" {
  description = "value to set the policy set definition name"
  type        = string

  validation {
    condition     = length(trim(var.policy_set_definition_name, " ")) > 0
    error_message = "policy_set_definition_name must not be empty."
  }
}

variable "display_name" {
  description = "value to set the display name"
  type        = string

  validation {
    condition     = length(trim(var.display_name, " ")) > 0
    error_message = "display_name must not be empty."
  }
}

variable "description" {
  description = "value to set the description"
  type        = string
  default     = null
}

variable "policy_type" {
  description = "value to set the policy type"
  type        = string
  default     = "Custom"
}

variable "management_group_id" {
  description = "value to set the management group id"
  type        = string
  default     = null
}

variable "metadata" {
  description = "value to set the metadata"
  type        = any
  default     = {}
}

variable "parameters" {
  description = "value to set the parameters"
  type        = any
  default     = null
}

variable "policy_definitions" {
  description = "value to set the policy definitions"
  type        = list(any)
}
