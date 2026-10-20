################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Front Door Profile."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the Front Door Profile."
  type        = bool
  default     = true
}

################################################################################
# Optional - Configuration
################################################################################

variable "sku_name" {
  description = "The SKU name. Possible values: Standard_AzureFrontDoor, Premium_AzureFrontDoor."
  type        = string
  default     = "Standard_AzureFrontDoor"
}

variable "response_timeout_seconds" {
  description = "The maximum response timeout in seconds."
  type        = number
  default     = 120
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}
