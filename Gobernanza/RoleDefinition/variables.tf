################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the custom role definition."
  type        = string
}

variable "scope" {
  description = "The scope at which the role definition is available (subscription or management group ID)."
  type        = string
}

variable "permissions" {
  description = "List of permissions for the role."
  type = list(object({
    actions          = optional(list(string), [])
    not_actions      = optional(list(string), [])
    data_actions     = optional(list(string), [])
    not_data_actions = optional(list(string), [])
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

variable "description" {
  description = "The description of the role definition."
  type        = string
  default     = null
}

variable "assignable_scopes" {
  description = "List of scopes where this role can be assigned. If null, uses the scope variable."
  type        = list(string)
  default     = null
}
