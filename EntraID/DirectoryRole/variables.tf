################################################################################
# Required Variables (one of these must be provided)
################################################################################

variable "display_name" {
  description = "The display name of the directory role to activate."
  type        = string
  default     = null
}

variable "template_id" {
  description = "The template ID of the directory role to activate."
  type        = string
  default     = null
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to activate the directory role."
  type        = bool
  default     = true
}
