################################################################################
# Required Variables
################################################################################

variable "role_id" {
  description = "The object ID of the directory role to assign."
  type        = string
}

variable "principal_object_id" {
  description = "The object ID of the principal (user, group, or service principal) to assign the role to."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the role assignment."
  type        = bool
  default     = true
}

################################################################################
# Optional - Scoped Assignment
################################################################################

variable "app_scope_id" {
  description = "The app scope ID for scoped role assignments (e.g., for application-scoped roles)."
  type        = string
  default     = null
}

variable "directory_scope_id" {
  description = "The directory scope ID for scoped role assignments (e.g., administrative unit ID)."
  type        = string
  default     = null
}
