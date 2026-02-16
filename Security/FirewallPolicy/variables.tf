################################################################################
# Required Variables
################################################################################

# DEPENDENCY: Resource Group must exist
variable "resource_group_name" {
  description = "The name of the resource group where the Firewall Policy will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the Firewall Policy will be created."
  type        = string
}

################################################################################
# Optional Variables - Naming
################################################################################

variable "name" {
  description = "The name of the Firewall Policy. If not provided, a name will be generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix for the Firewall Policy name."
  type        = string
  default     = "fwp"
}

variable "workload" {
  description = "The workload name for naming convention."
  type        = string
  default     = ""
}

variable "environment" {
  description = "The environment name (dev, staging, prod) for naming convention."
  type        = string
  default     = ""
}

variable "instance" {
  description = "The instance identifier for naming convention."
  type        = string
  default     = "001"
}

################################################################################
# Optional Variables - Configuration
################################################################################

variable "create" {
  description = "Controls whether resources should be created."
  type        = bool
  default     = true
}

variable "sku" {
  description = "The SKU tier for the Firewall Policy. Possible values are Basic, Standard, and Premium."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "SKU must be Basic, Standard, or Premium."
  }
}

variable "base_policy_id" {
  description = "The ID of the base Firewall Policy for policy inheritance."
  type        = string
  default     = null
}

variable "threat_intelligence_mode" {
  description = "The operation mode for threat intelligence-based filtering. Possible values are Alert, Deny, and Off."
  type        = string
  default     = "Alert"

  validation {
    condition     = contains(["Alert", "Deny", "Off"], var.threat_intelligence_mode)
    error_message = "Threat intelligence mode must be Alert, Deny, or Off."
  }
}

variable "threat_intelligence_allowlist" {
  description = "Threat intelligence allowlist configuration."
  type = object({
    fqdns        = optional(list(string), [])
    ip_addresses = optional(list(string), [])
  })
  default = null
}

variable "dns" {
  description = "DNS configuration for the Firewall Policy."
  type = object({
    proxy_enabled = optional(bool, false)
    servers       = optional(list(string), [])
  })
  default = null
}

variable "intrusion_detection" {
  description = "Intrusion detection configuration (requires Premium SKU)."
  type = object({
    mode = optional(string, "Off")
    signature_overrides = optional(list(object({
      id    = optional(string)
      state = optional(string)
    })), [])
    traffic_bypass = optional(list(object({
      name                  = string
      protocol              = string
      description           = optional(string)
      destination_addresses = optional(list(string), [])
      destination_ip_groups = optional(list(string), [])
      destination_ports     = optional(list(string), [])
      source_addresses      = optional(list(string), [])
      source_ip_groups      = optional(list(string), [])
    })), [])
  })
  default = null
}

variable "insights" {
  description = "Insights and logging configuration for the Firewall Policy."
  type = object({
    enabled                            = optional(bool, true)
    default_log_analytics_workspace_id = string
    retention_in_days                  = optional(number, 30)
    log_analytics_workspace = optional(list(object({
      id                = string
      firewall_location = string
    })), [])
  })
  default = null
}

################################################################################
# Optional Variables - Tags
################################################################################

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
