################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Metric Alert."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "scopes" {
  description = "List of resource IDs to monitor."
  type        = list(string)
}

variable "criteria" {
  description = "List of metric criteria."
  type = list(object({
    metric_namespace = string
    metric_name      = string
    aggregation      = string
    operator         = string
    threshold        = number
  }))
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the Metric Alert."
  type        = bool
  default     = true
}

################################################################################
# Optional - Configuration
################################################################################

variable "description" {
  description = "The description of the Metric Alert."
  type        = string
  default     = null
}

variable "enabled" {
  description = "Whether the Metric Alert is enabled."
  type        = bool
  default     = true
}

variable "auto_mitigate" {
  description = "Whether to auto-resolve the alert."
  type        = bool
  default     = true
}

variable "frequency" {
  description = "The evaluation frequency. Possible values: PT1M, PT5M, PT15M, PT30M, PT1H."
  type        = string
  default     = "PT5M"
}

variable "severity" {
  description = "The severity of the alert. Possible values: 0 (Critical), 1 (Error), 2 (Warning), 3 (Informational), 4 (Verbose)."
  type        = number
  default     = 3
}

variable "window_size" {
  description = "The period of time to evaluate. Possible values: PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H, P1D."
  type        = string
  default     = "PT5M"
}

variable "action_group_ids" {
  description = "List of Action Group IDs to notify."
  type        = list(string)
  default     = []
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}
