#############################################################################
# VARIABLES RESOURCE LOCK
#############################################################################
variable "lock_name" {
  description = "value to set the lock name"
  type        = string

  validation {
    condition     = length(trim(var.lock_name, " ")) > 0
    error_message = "lock_name must not be empty."
  }
}

variable "scope" {
  description = "value to set the scope"
  type        = string

  validation {
    condition     = length(trim(var.scope, " ")) > 0
    error_message = "scope must not be empty."
  }
}

variable "lock_level" {
  description = "value to set the lock level"
  type        = string

  validation {
    condition     = contains(["CanNotDelete", "ReadOnly"], var.lock_level)
    error_message = "lock_level must be CanNotDelete or ReadOnly."
  }
}

variable "notes" {
  description = "value to set the notes"
  type        = string
  default     = null
}
