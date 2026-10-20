################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the protection container."
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

variable "recovery_fabric_name" {
  description = "The name of the Site Recovery Fabric."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the protection container."
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
