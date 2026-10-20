#############################################################################
# VARIABLES AI FOUNDRY
#############################################################################
variable "ai_foundry_name" {
  description = "value to set the ai foundry name"
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

variable "storage_account_id" {
  description = "value to set the storage account id"
  type        = string
}

variable "key_vault_id" {
  description = "value to set the key vault id"
  type        = string
}

variable "identity" {
  description = "value to set the identity"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
}

variable "application_insights_id" {
  description = "value to set the application insights id"
  type        = string
  default     = null
}

variable "container_registry_id" {
  description = "value to set the container registry id"
  type        = string
  default     = null
}

variable "description" {
  description = "value to set the description"
  type        = string
  default     = null
}

variable "friendly_name" {
  description = "value to set the friendly name"
  type        = string
  default     = null
}

variable "high_business_impact_enabled" {
  description = "value to set the high business impact enabled flag"
  type        = bool
  default     = null
}

variable "primary_user_assigned_identity" {
  description = "value to set the primary user assigned identity"
  type        = string
  default     = null
}

variable "public_network_access" {
  description = "value to set the public network access"
  type        = string
  default     = null
}

variable "encryption" {
  description = "value to set the encryption"
  type = object({
    key_id                    = string
    key_vault_id              = string
    user_assigned_identity_id = optional(string)
  })
  default = null
}

variable "managed_network" {
  description = "value to set the managed network"
  type = object({
    isolation_mode = optional(string)
  })
  default = null
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
