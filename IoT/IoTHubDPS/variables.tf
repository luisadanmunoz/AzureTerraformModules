################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the IoT Hub Device Provisioning Service."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the DPS."
  type        = string
}

variable "location" {
  description = "The Azure region where the DPS should be created."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the DPS resource."
  type        = bool
  default     = true
}

################################################################################
# Optional - SKU Configuration
################################################################################

variable "sku_name" {
  description = "The name of the SKU. Currently only S1 is supported."
  type        = string
  default     = "S1"

  validation {
    condition     = var.sku_name == "S1"
    error_message = "Currently only S1 SKU is supported for DPS."
  }
}

variable "sku_capacity" {
  description = "The number of units to provision."
  type        = number
  default     = 1
}

################################################################################
# Optional - Configuration
################################################################################

variable "allocation_policy" {
  description = "The allocation policy for the DPS. Possible values are Hashed, GeoLatency, or Static."
  type        = string
  default     = "Hashed"

  validation {
    condition     = contains(["Hashed", "GeoLatency", "Static"], var.allocation_policy)
    error_message = "The allocation_policy must be one of: Hashed, GeoLatency, Static."
  }
}

variable "data_residency_enabled" {
  description = "Whether data residency is enabled."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled."
  type        = bool
  default     = true
}

################################################################################
# Optional - Linked IoT Hubs
################################################################################

variable "linked_hubs" {
  description = "List of IoT Hubs to link to the DPS."
  type = list(object({
    connection_string       = string
    location                = string
    apply_allocation_policy = optional(bool, true)
    allocation_weight       = optional(number, 1)
  }))
  default   = []
  sensitive = true
}

################################################################################
# Optional - IP Filter Rules
################################################################################

variable "ip_filter_rules" {
  description = "IP filter rules for the DPS."
  type = list(object({
    name    = string
    ip_mask = string
    action  = string
    target  = optional(string)
  }))
  default = []
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags to apply to the DPS."
  type        = map(string)
  default     = {}
}
