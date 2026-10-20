################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Diagnostic Setting."
  type        = string
}

variable "target_resource_id" {
  description = "The ID of the resource to apply diagnostic settings to."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the Diagnostic Setting."
  type        = bool
  default     = true
}

################################################################################
# Optional - Destinations
################################################################################

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace destination."
  type        = string
  default     = null
}

variable "storage_account_id" {
  description = "The ID of the Storage Account destination."
  type        = string
  default     = null
}

variable "eventhub_authorization_rule_id" {
  description = "The ID of the Event Hub authorization rule."
  type        = string
  default     = null
}

variable "eventhub_name" {
  description = "The name of the Event Hub."
  type        = string
  default     = null
}

variable "log_analytics_destination_type" {
  description = "The destination type for Log Analytics. Possible values: Dedicated, AzureDiagnostics."
  type        = string
  default     = null
}

################################################################################
# Optional - Logs and Metrics
################################################################################

variable "enabled_logs" {
  description = "List of log categories to enable."
  type = list(object({
    category       = optional(string)
    category_group = optional(string)
    retention_policy = optional(object({
      enabled = bool
      days    = optional(number, 0)
    }))
  }))
  default = []
}

variable "metrics" {
  description = "List of metric categories to enable."
  type = list(object({
    category = string
    enabled  = optional(bool, true)
    retention_policy = optional(object({
      enabled = bool
      days    = optional(number, 0)
    }))
  }))
  default = []
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags (not applied to diagnostic settings, kept for consistency)."
  type        = map(string)
  default     = {}
}
