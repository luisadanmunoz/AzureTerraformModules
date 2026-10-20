################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to enable backup protection."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group containing the Vault. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "recovery_vault_name" {
  description = "(Required) The name of the Recovery Services Vault. DEPENDENCY: Vault must exist."
  type        = string
}

variable "backup_policy_id" {
  description = "(Required) The ID of the Backup Policy. DEPENDENCY: Backup Policy must exist."
  type        = string
}

################################################################################
# VM Protection
################################################################################

variable "source_vm_id" {
  description = "(Required) The ID of the VM to protect. DEPENDENCY: VM must exist."
  type        = string
}

variable "include_disk_luns" {
  description = "(Optional) List of disk LUNs to include in backup. If null, all disks are included."
  type        = list(number)
  default     = null
}

variable "exclude_disk_luns" {
  description = "(Optional) List of disk LUNs to exclude from backup."
  type        = list(number)
  default     = null
}

variable "protection_state" {
  description = "(Optional) The protection state. Values: Invalid, IRPending, Protected, etc."
  type        = string
  default     = null
}
