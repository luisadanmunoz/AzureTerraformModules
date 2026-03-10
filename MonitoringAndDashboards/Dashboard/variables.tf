################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Dashboard."
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
  description = "Whether to create the Dashboard."
  type        = bool
  default     = true
}

################################################################################
# Optional - Configuration
################################################################################

variable "dashboard_properties" {
  description = "The JSON definition of the dashboard layout and tiles."
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
