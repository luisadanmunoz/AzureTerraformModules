################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Arc-enabled Kubernetes cluster."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region where the Arc cluster will be registered."
  type        = string
}

variable "agent_public_key_certificate" {
  description = "The base64-encoded public certificate used by the agent for authentication."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the Arc Kubernetes cluster resource."
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
