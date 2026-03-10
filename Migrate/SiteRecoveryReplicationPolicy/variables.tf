################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the replication policy."
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

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the replication policy."
  type        = bool
  default     = true
}

################################################################################
# Optional - Configuration
################################################################################

variable "recovery_point_retention_in_minutes" {
  description = "The duration in minutes for which recovery points are retained."
  type        = number
  default     = 1440
}

variable "application_consistent_snapshot_frequency_in_minutes" {
  description = "The frequency in minutes for application-consistent snapshots."
  type        = number
  default     = 240
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}
