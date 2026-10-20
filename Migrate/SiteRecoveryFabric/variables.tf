################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Site Recovery Fabric."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "recovery_vault_name" {
  description = "The name of the Recovery Services Vault."
  type        = string
}

variable "location" {
  description = "The Azure region for the fabric."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the Site Recovery Fabric."
  type        = bool
  default     = true
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}
