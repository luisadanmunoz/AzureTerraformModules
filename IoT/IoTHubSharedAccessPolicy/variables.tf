################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the shared access policy."
  type        = string
}

variable "iothub_name" {
  description = "The name of the IoT Hub."
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
  description = "Whether to create the shared access policy resource."
  type        = bool
  default     = true
}

################################################################################
# Optional - Permissions
################################################################################

variable "registry_read" {
  description = "Whether to grant registry read permission."
  type        = bool
  default     = false
}

variable "registry_write" {
  description = "Whether to grant registry write permission. Implies registry_read."
  type        = bool
  default     = false
}

variable "service_connect" {
  description = "Whether to grant service connect permission."
  type        = bool
  default     = false
}

variable "device_connect" {
  description = "Whether to grant device connect permission."
  type        = bool
  default     = false
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags (not applied to resource, kept for consistency)."
  type        = map(string)
  default     = {}
}
