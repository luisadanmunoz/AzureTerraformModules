################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the route."
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

variable "source_type" {
  description = "The source for the route. Possible values are DeviceConnectionStateEvents, DeviceJobLifecycleEvents, DeviceLifecycleEvents, DeviceMessages, DigitalTwinChangeEvents, Invalid, TwinChangeEvents."
  type        = string

  validation {
    condition = contains([
      "DeviceConnectionStateEvents",
      "DeviceJobLifecycleEvents",
      "DeviceLifecycleEvents",
      "DeviceMessages",
      "DigitalTwinChangeEvents",
      "Invalid",
      "TwinChangeEvents"
    ], var.source_type)
    error_message = "The source_type must be one of: DeviceConnectionStateEvents, DeviceJobLifecycleEvents, DeviceLifecycleEvents, DeviceMessages, DigitalTwinChangeEvents, Invalid, TwinChangeEvents."
  }
}

variable "endpoint_names" {
  description = "The list of endpoint names for the route."
  type        = list(string)
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the route resource."
  type        = bool
  default     = true
}

################################################################################
# Optional - Configuration
################################################################################

variable "condition" {
  description = "The condition evaluated to apply the route. Defaults to true."
  type        = string
  default     = "true"
}

variable "enabled" {
  description = "Whether the route is enabled."
  type        = bool
  default     = true
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags (not applied to resource, kept for consistency)."
  type        = map(string)
  default     = {}
}
