################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Search Service."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region."
  type        = string
}

variable "sku" {
  description = "The SKU. Possible values: free, basic, standard, standard2, standard3, storage_optimized_l1, storage_optimized_l2."
  type        = string
  default     = "standard"
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the search service."
  type        = bool
  default     = true
}

################################################################################
# Optional - Configuration
################################################################################

variable "replica_count" {
  description = "The number of replicas."
  type        = number
  default     = 1
}

variable "partition_count" {
  description = "The number of partitions."
  type        = number
  default     = 1
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled."
  type        = bool
  default     = true
}

variable "local_authentication_enabled" {
  description = "Whether local authentication is enabled."
  type        = bool
  default     = true
}

variable "authentication_failure_mode" {
  description = "The failure mode for authentication. Possible values: http401WithBearerChallenge, http403."
  type        = string
  default     = null
}

variable "customer_managed_key_enforcement_enabled" {
  description = "Whether customer managed key enforcement is enabled."
  type        = bool
  default     = false
}

variable "hosting_mode" {
  description = "The hosting mode. Possible values: default, highDensity."
  type        = string
  default     = "default"
}

variable "semantic_search_sku" {
  description = "The SKU for semantic search. Possible values: free, standard."
  type        = string
  default     = null
}

variable "allowed_ips" {
  description = "List of allowed IP addresses."
  type        = list(string)
  default     = []
}

################################################################################
# Optional - Identity
################################################################################

variable "identity_type" {
  description = "The type of managed identity."
  type        = string
  default     = null
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}
