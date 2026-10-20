################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Azure OpenAI account."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region for the OpenAI account."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the OpenAI account."
  type        = bool
  default     = true
}

################################################################################
# Optional - SKU
################################################################################

variable "sku_name" {
  description = "The SKU of the OpenAI account. Typically S0."
  type        = string
  default     = "S0"
}

################################################################################
# Optional - Network
################################################################################

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled."
  type        = bool
  default     = true
}

variable "outbound_network_access_restricted" {
  description = "Whether outbound network access is restricted."
  type        = bool
  default     = false
}

variable "network_acls" {
  description = "Network ACLs for the OpenAI account."
  type = object({
    default_action = string
    ip_rules       = optional(list(string), [])
    virtual_network_rules = optional(list(object({
      subnet_id                            = string
      ignore_missing_vnet_service_endpoint = optional(bool, false)
    })), [])
  })
  default = null
}

################################################################################
# Optional - Identity
################################################################################

variable "identity_type" {
  description = "The type of managed identity. Possible values: SystemAssigned, UserAssigned, SystemAssigned, UserAssigned."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "List of User Assigned Managed Identity IDs."
  type        = list(string)
  default     = []
}

################################################################################
# Optional - Customer Managed Key
################################################################################

variable "customer_managed_key" {
  description = "Customer managed key configuration."
  type = object({
    key_vault_key_id   = string
    identity_client_id = optional(string)
  })
  default = null
}

################################################################################
# Optional - Other Settings
################################################################################

variable "custom_subdomain_name" {
  description = "The custom subdomain name for the OpenAI account."
  type        = string
  default     = null
}

variable "dynamic_throttling_enabled" {
  description = "Whether dynamic throttling is enabled."
  type        = bool
  default     = false
}

variable "fqdns" {
  description = "List of FQDNs allowed for the OpenAI account."
  type        = list(string)
  default     = []
}

variable "local_auth_enabled" {
  description = "Whether local authentication is enabled."
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
