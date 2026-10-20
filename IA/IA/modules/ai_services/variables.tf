#############################################################################
# VARIABLES AI SERVICES
#############################################################################
variable "ai_services_name" {
  description = "value to set the ai services name"
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

variable "sku_name" {
  description = "value to set the sku name"
  type        = string
}

variable "custom_subdomain_name" {
  description = "value to set the custom subdomain name"
  type        = string
  default     = null
}

variable "fqdns" {
  description = "value to set the fqdns"
  type        = list(string)
  default     = null
}

variable "local_authentication_enabled" {
  description = "value to set the local authentication enabled flag"
  type        = bool
  default     = null
}

variable "outbound_network_access_restricted" {
  description = "value to set the outbound network access restricted flag"
  type        = bool
  default     = null
}

variable "public_network_access" {
  description = "value to set the public network access"
  type        = string
  default     = null
}

variable "customer_managed_key" {
  description = "value to set the customer managed key"
  type = object({
    identity_client_id = optional(string)
    key_vault_key_id   = optional(string)
    managed_hsm_key_id = optional(string)
  })
  default = null
}

variable "identity" {
  description = "value to set the identity"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "network_acls" {
  description = "value to set the network acls"
  type = object({
    bypass         = optional(string)
    default_action = string
    ip_rules       = optional(list(string))
    virtual_network_rules = optional(list(object({
      subnet_id                            = string
      ignore_missing_vnet_service_endpoint = optional(bool)
    })))
  })
  default = null
}

variable "storage" {
  description = "value to set the storage"
  type = object({
    storage_account_id = string
    identity_client_id = optional(string)
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
