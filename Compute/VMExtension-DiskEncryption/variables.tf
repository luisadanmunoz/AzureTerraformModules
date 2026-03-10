################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the extension."
  type        = bool
  default     = true
}

variable "virtual_machine_id" {
  description = "(Required) The ID of the Virtual Machine. DEPENDENCY: VM must exist."
  type        = string
}

variable "os_type" {
  description = "(Required) OS type. Values: Linux, Windows."
  type        = string

  validation {
    condition     = contains(["Linux", "Windows"], var.os_type)
    error_message = "os_type must be either 'Linux' or 'Windows'."
  }
}

################################################################################
# Extension Configuration
################################################################################

variable "name" {
  description = "(Optional) Extension name. Default: AzureDiskEncryption."
  type        = string
  default     = "AzureDiskEncryption"
}

variable "auto_upgrade_minor_version" {
  description = "(Optional) Auto upgrade minor version. Default: true."
  type        = bool
  default     = true
}

################################################################################
# Disk Encryption Configuration
################################################################################

variable "key_vault_url" {
  description = "(Required) The URL of the Key Vault. DEPENDENCY: Key Vault must exist."
  type        = string
}

variable "key_vault_resource_id" {
  description = "(Required) The Resource ID of the Key Vault."
  type        = string
}

variable "key_encryption_key_url" {
  description = "(Optional) The URL of the Key Encryption Key (KEK). If not provided, BEK-only encryption is used."
  type        = string
  default     = null
}

variable "volume_type" {
  description = "(Optional) Volume type to encrypt. Values: OS, Data, All. Default: All."
  type        = string
  default     = "All"

  validation {
    condition     = contains(["OS", "Data", "All"], var.volume_type)
    error_message = "volume_type must be OS, Data, or All."
  }
}

variable "encryption_operation" {
  description = "(Optional) Encryption operation. Values: EnableEncryption, DisableEncryption. Default: EnableEncryption."
  type        = string
  default     = "EnableEncryption"

  validation {
    condition     = contains(["EnableEncryption", "DisableEncryption"], var.encryption_operation)
    error_message = "encryption_operation must be EnableEncryption or DisableEncryption."
  }
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
