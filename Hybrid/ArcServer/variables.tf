################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Arc-enabled server."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region where the Arc server will be registered."
  type        = string
}

variable "kind" {
  description = "The kind of Arc machine. Possible values: HCI, SCVMM, VMware, EPS, GCP, AWS."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the Arc server resource."
  type        = bool
  default     = true
}

################################################################################
# Optional - Identity
################################################################################

variable "identity_type" {
  description = "The type of managed identity. Only SystemAssigned is supported."
  type        = string
  default     = "SystemAssigned"
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}
