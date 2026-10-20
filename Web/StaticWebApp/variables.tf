################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Static Web App."
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

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the Static Web App."
  type        = bool
  default     = true
}

################################################################################
# Optional - Configuration
################################################################################

variable "sku_tier" {
  description = "The SKU tier. Possible values: Free, Standard."
  type        = string
  default     = "Free"
}

variable "sku_size" {
  description = "The SKU size. Possible values: Free, Standard."
  type        = string
  default     = "Free"
}

variable "app_settings" {
  description = "A map of application settings."
  type        = map(string)
  default     = {}
}

################################################################################
# Optional - Identity
################################################################################

variable "identity_type" {
  description = "The type of managed identity. Possible values: SystemAssigned, UserAssigned, SystemAssigned, UserAssigned."
  type        = string
  default     = null
}

variable "identity_ids" {
  description = "List of User Assigned Identity IDs."
  type        = list(string)
  default     = []
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}
