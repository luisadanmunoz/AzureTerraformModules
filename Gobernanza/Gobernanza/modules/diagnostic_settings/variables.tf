#############################################################################
# VARIABLES DIAGNOSTIC SETTINGS
#############################################################################
variable "diagnostic_settings_name" {
  description = "value to set the diagnostic settings name"
  type        = string

  validation {
    condition     = length(trim(var.diagnostic_settings_name, " ")) > 0
    error_message = "diagnostic_settings_name must not be empty."
  }
}

variable "target_resource_id" {
  description = "value to set the target resource id"
  type        = string

  validation {
    condition     = length(trim(var.target_resource_id, " ")) > 0
    error_message = "target_resource_id must not be empty."
  }
}

variable "log_analytics_workspace_id" {
  description = "value to set the log analytics workspace id"
  type        = string
  default     = null
}

variable "log_analytics_destination_type" {
  description = "value to set the log analytics destination type"
  type        = string
  default     = null
}

variable "storage_account_id" {
  description = "value to set the storage account id"
  type        = string
  default     = null
}

variable "eventhub_authorization_rule_id" {
  description = "value to set the eventhub authorization rule id"
  type        = string
  default     = null
}

variable "eventhub_name" {
  description = "value to set the eventhub name"
  type        = string
  default     = null
}

variable "log_categories" {
  description = "value to set the log categories"
  type        = list(string)
  default     = []
}

variable "metric_categories" {
  description = "value to set the metric categories"
  type        = list(string)
  default     = ["AllMetrics"]
}
