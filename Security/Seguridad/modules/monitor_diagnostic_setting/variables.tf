#############################################################################
# VARIABLES MONITOR DIAGNOSTIC SETTING
#############################################################################
variable "monitor_diagnostic_setting_name" {
  description = "value to set the monitor diagnostic setting name"
  type        = string
}

variable "target_resource_id" {
  description = "value to set the target resource id"
  type        = string
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

variable "partner_solution_id" {
  description = "value to set the partner solution id"
  type        = string
  default     = null
}

variable "enabled_logs" {
  description = "value to set the enabled logs"
  type = list(object({
    category       = optional(string)
    category_group = optional(string)
    retention_policy = optional(object({
      enabled = bool
      days    = optional(number)
    }))
  }))
  default = []
}

variable "enabled_metrics" {
  description = "value to set the enabled metrics"
  type = list(object({
    category = string
  }))
  default = []
}

variable "metrics" {
  description = "value to set the metrics"
  type = list(object({
    category = string
    enabled  = optional(bool)
    retention_policy = optional(object({
      enabled = bool
      days    = optional(number)
    }))
  }))
  default = []
}

variable "timeouts" {
  description = "value to set the timeouts"
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}
