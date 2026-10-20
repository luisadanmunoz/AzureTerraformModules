################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Relay Namespace."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region for the Relay Namespace."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the Relay Namespace."
  type        = bool
  default     = true
}

################################################################################
# Optional - SKU
################################################################################

variable "sku_name" {
  description = "The SKU of the Relay Namespace. Only Standard is supported."
  type        = string
  default     = "Standard"
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}
