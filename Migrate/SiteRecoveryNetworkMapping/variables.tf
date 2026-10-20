################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the network mapping."
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

variable "source_recovery_fabric_name" {
  description = "The name of the source Site Recovery Fabric."
  type        = string
}

variable "target_recovery_fabric_name" {
  description = "The name of the target Site Recovery Fabric."
  type        = string
}

variable "source_network_id" {
  description = "The ID of the source virtual network."
  type        = string
}

variable "target_network_id" {
  description = "The ID of the target virtual network."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the network mapping."
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
