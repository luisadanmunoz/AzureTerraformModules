################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Hybrid Connection."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "relay_namespace_name" {
  description = "The name of the Relay Namespace."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the Hybrid Connection."
  type        = bool
  default     = true
}

################################################################################
# Optional - Configuration
################################################################################

variable "requires_client_authorization" {
  description = "Whether client authorization is required."
  type        = bool
  default     = true
}

variable "user_metadata" {
  description = "User-defined metadata in the format hostname:port."
  type        = string
  default     = null
}
