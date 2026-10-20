#############################################################################
# VARIABLES KEY VAULT
#############################################################################
variable "key_vault_name" {
  description = "value to set the key vault name"
  type        = string
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "location" {
  description = "value to set the location"
  type        = string
}

variable "tenant_id" {
  description = "value to set the tenant id"
  type        = string
}

variable "sku_name" {
  description = "value to set the sku name"
  type        = string
}

variable "enabled_for_deployment" {
  description = "value to set the enabled for deployment flag"
  type        = bool
  default     = null
}

variable "enabled_for_disk_encryption" {
  description = "value to set the enabled for disk encryption flag"
  type        = bool
  default     = null
}

variable "enabled_for_template_deployment" {
  description = "value to set the enabled for template deployment flag"
  type        = bool
  default     = null
}

variable "public_network_access_enabled" {
  description = "value to set the public network access enabled flag"
  type        = bool
  default     = null
}

variable "purge_protection_enabled" {
  description = "value to set the purge protection enabled flag"
  type        = bool
  default     = null
}

variable "rbac_authorization_enabled" {
  description = "value to set the rbac authorization enabled flag"
  type        = bool
  default     = null
}

variable "soft_delete_retention_days" {
  description = "value to set the soft delete retention days"
  type        = number
  default     = null
}

variable "network_acls" {
  description = "value to set the network acls"
  type = object({
    bypass                     = string
    default_action             = string
    ip_rules                   = optional(list(string))
    virtual_network_subnet_ids = optional(list(string))
  })
  default = null
}

variable "access_policies" {
  description = "value to set the access policies"
  type = list(object({
    tenant_id               = string
    object_id               = string
    application_id          = optional(string)
    key_permissions         = optional(list(string))
    secret_permissions      = optional(list(string))
    certificate_permissions = optional(list(string))
    storage_permissions     = optional(list(string))
  }))
  default = []
}

variable "timeouts" {
  description = "value to set the timeouts"
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
