################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the CDN Profile."
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
  description = "Whether to create the CDN Profile."
  type        = bool
  default     = true
}

################################################################################
# Optional - Configuration
################################################################################

variable "sku" {
  description = "The SKU. Possible values: Standard_Akamai, Standard_Microsoft, Standard_Verizon, Premium_Verizon."
  type        = string
  default     = "Standard_Microsoft"
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}
