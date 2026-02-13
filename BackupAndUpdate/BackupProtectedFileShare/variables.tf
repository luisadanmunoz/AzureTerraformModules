################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the backup protected file share."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group where the Recovery Vault exists. DEPENDENCY: Resource Group must exist."
  type        = string
}

################################################################################
# Backup Configuration
################################################################################

variable "recovery_vault_name" {
  description = "(Required) The name of the Recovery Services Vault. DEPENDENCY: Recovery Vault must exist."
  type        = string
}

variable "source_storage_account_id" {
  description = "(Required) The ID of the Storage Account containing the file share. DEPENDENCY: Storage Account must exist."
  type        = string
}

variable "source_file_share_name" {
  description = "(Required) The name of the file share to backup. DEPENDENCY: File Share must exist."
  type        = string
}

variable "backup_policy_id" {
  description = "(Required) The ID of the backup policy to use. DEPENDENCY: Backup Policy must exist."
  type        = string
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
