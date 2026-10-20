################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Machine Learning Workspace."
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

variable "application_insights_id" {
  description = "The ID of the Application Insights instance."
  type        = string
}

variable "key_vault_id" {
  description = "The ID of the Key Vault."
  type        = string
}

variable "storage_account_id" {
  description = "The ID of the Storage Account."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the workspace."
  type        = bool
  default     = true
}

################################################################################
# Optional - Identity
################################################################################

variable "identity_type" {
  description = "The type of managed identity."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "List of User Assigned Managed Identity IDs."
  type        = list(string)
  default     = []
}

################################################################################
# Optional - Configuration
################################################################################

variable "container_registry_id" {
  description = "The ID of the Container Registry."
  type        = string
  default     = null
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled."
  type        = bool
  default     = true
}

variable "image_build_compute_name" {
  description = "The compute name for image build."
  type        = string
  default     = null
}

variable "description" {
  description = "A description of the workspace."
  type        = string
  default     = null
}

variable "friendly_name" {
  description = "A friendly name for the workspace."
  type        = string
  default     = null
}

variable "high_business_impact" {
  description = "Whether this is a high business impact workspace."
  type        = bool
  default     = false
}

variable "sku_name" {
  description = "The SKU of the workspace. Possible values: Basic, Enterprise."
  type        = string
  default     = "Basic"
}

variable "v1_legacy_mode_enabled" {
  description = "Whether v1 legacy mode is enabled."
  type        = bool
  default     = false
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}
