#############################################################################
# VARIABLES ROLE ASSIGNMENT
#############################################################################
variable "scope" {
  description = "value to set the scope"
  type        = string

  validation {
    condition     = length(trim(var.scope, " ")) > 0
    error_message = "scope must not be empty."
  }
}

variable "principal_id" {
  description = "value to set the principal id"
  type        = string

  validation {
    condition     = length(trim(var.principal_id, " ")) > 0
    error_message = "principal_id must not be empty."
  }
}

variable "role_definition_name" {
  description = "value to set the role definition name"
  type        = string
  default     = null
}

variable "role_definition_id" {
  description = "value to set the role definition id"
  type        = string
  default     = null
}

variable "principal_type" {
  description = "value to set the principal type"
  type        = string
  default     = null
}

variable "description" {
  description = "value to set the description"
  type        = string
  default     = null
}

variable "condition" {
  description = "value to set the condition"
  type        = string
  default     = null
}

variable "condition_version" {
  description = "value to set the condition version"
  type        = string
  default     = null
}

variable "skip_service_principal_aad_check" {
  description = "value to skip service principal aad check"
  type        = bool
  default     = false
}
