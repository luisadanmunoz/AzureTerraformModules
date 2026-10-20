################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Digital Twins instance."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Digital Twins instance."
  type        = string
}

variable "location" {
  description = "The Azure region where the Digital Twins instance should be created."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the Digital Twins resource."
  type        = bool
  default     = true
}

################################################################################
# Optional - Identity
################################################################################

variable "identity_type" {
  description = "The type of managed identity. Possible values are SystemAssigned, UserAssigned, or SystemAssigned, UserAssigned."
  type        = string
  default     = null
}

variable "identity_ids" {
  description = "A list of user-assigned managed identity IDs."
  type        = list(string)
  default     = []
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags to apply to the Digital Twins instance."
  type        = map(string)
  default     = {}
}
