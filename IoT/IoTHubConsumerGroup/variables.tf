################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the consumer group."
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

variable "eventhub_endpoint_name" {
  description = "The name of the Event Hub-compatible endpoint in the IoT Hub."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the consumer group resource."
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
