################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Resource Mover Move Collection."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "source_region" {
  description = "The source Azure region."
  type        = string
}

variable "target_region" {
  description = "The target Azure region."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the Resource Mover Move Collection."
  type        = bool
  default     = true
}

################################################################################
# Optional - Identity
################################################################################

variable "identity_type" {
  description = "The type of managed identity. Possible values: SystemAssigned."
  type        = string
  default     = "SystemAssigned"
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}
