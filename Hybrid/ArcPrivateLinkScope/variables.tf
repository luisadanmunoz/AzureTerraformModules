################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Arc Private Link Scope."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region for the Private Link Scope."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the Arc Private Link Scope."
  type        = bool
  default     = true
}

################################################################################
# Optional - Network Access
################################################################################

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled. Set to false for private-only access."
  type        = bool
  default     = false
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}
