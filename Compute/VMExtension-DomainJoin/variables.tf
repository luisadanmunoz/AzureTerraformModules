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

################################################################################
# Extension Configuration
################################################################################

variable "name" {
  description = "(Optional) Extension name. Default: DomainJoin."
  type        = string
  default     = "DomainJoin"
}

variable "auto_upgrade_minor_version" {
  description = "(Optional) Auto upgrade minor version. Default: true."
  type        = bool
  default     = true
}

################################################################################
# Domain Join Configuration
################################################################################

variable "domain_name" {
  description = "(Required) The FQDN of the Active Directory domain to join."
  type        = string
}

variable "domain_username" {
  description = "(Required) Username with permissions to join the domain (e.g., admin@domain.com)."
  type        = string
}

variable "domain_password" {
  description = "(Required) Password for the domain user."
  type        = string
  sensitive   = true
}

variable "ou_path" {
  description = "(Optional) The OU path where the computer account will be created."
  type        = string
  default     = null
}

variable "join_options" {
  description = "(Optional) Domain join options. Default: 3 (NETSETUP_JOIN_DOMAIN + NETSETUP_ACCT_CREATE)."
  type        = number
  default     = 3
}

variable "restart" {
  description = "(Optional) Restart after domain join. Default: true."
  type        = string
  default     = "true"
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
