################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Database Migration Service."
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

variable "subnet_id" {
  description = "The ID of the subnet where the DMS instance will be deployed."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the Database Migration Service."
  type        = bool
  default     = true
}

################################################################################
# Optional - Configuration
################################################################################

variable "sku_name" {
  description = "The SKU name. Possible values: Standard_1vCores, Standard_2vCores, Standard_4vCores, Premium_4vCores."
  type        = string
  default     = "Standard_1vCores"
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}
