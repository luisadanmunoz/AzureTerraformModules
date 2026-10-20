#############################################################################
# VARIABLES COGNITIVE ACCOUNT
#############################################################################
variable "cognitive_account_name" {
  description = "value to set the cognitive account name"
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

variable "kind" {
  description = "value to set the kind"
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

variable "dynamic_throttling_enabled" {
  description = "value to set the dynamic throttling enabled flag"
  type        = bool
  default     = null
}

variable "fqdns" {
  description = "value to set the fqdns"
  type        = list(string)
  default     = null
}

variable "local_auth_enabled" {
  description = "value to set the local auth enabled flag"
  type        = bool
  default     = null
}

variable "metrics_advisor_aad_client_id" {
  description = "value to set the metrics advisor aad client id"
  type        = string
  default     = null
}

variable "metrics_advisor_aad_tenant_id" {
  description = "value to set the metrics advisor aad tenant id"
  type        = string
  default     = null
}

variable "metrics_advisor_super_user_name" {
  description = "value to set the metrics advisor super user name"
  type        = string
  default     = null
}

variable "metrics_advisor_website_name" {
  description = "value to set the metrics advisor website name"
  type        = string
  default     = null
}

variable "outbound_network_access_restricted" {
  description = "value to set the outbound network access restricted flag"
  type        = bool
  default     = null
}

variable "project_management_enabled" {
  description = "value to set the project management enabled flag"
  type        = bool
  default     = null
}

variable "public_network_access_enabled" {
  description = "value to set the public network access enabled flag"
  type        = bool
  default     = null
}

variable "qna_runtime_endpoint" {
  description = "value to set the qna runtime endpoint"
  type        = string
  default     = null
}

variable "custom_question_answering_search_service_id" {
  description = "value to set the custom question answering search service id"
  type        = string
  default     = null
}

variable "custom_question_answering_search_service_key" {
  description = "value to set the custom question answering search service key"
  type        = string
  default     = null
}

variable "customer_managed_key" {
  description = "value to set the customer managed key"
  type = object({
    key_vault_key_id   = string
    identity_client_id = optional(string)
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

variable "network_injection" {
  description = "value to set the network injection"
  type = object({
    scenario  = string
    subnet_id = string
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
