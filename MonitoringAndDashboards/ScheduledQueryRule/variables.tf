################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Scheduled Query Rule Alert."
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

variable "scopes" {
  description = "List of resource IDs to scope the alert."
  type        = list(string)
}

variable "criteria" {
  description = "The criteria for the alert."
  type = object({
    query                   = string
    time_aggregation_method = string
    threshold               = number
    operator                = string
    metric_measure_column   = optional(string)
    resource_id_column      = optional(string)
    dimension = optional(list(object({
      name     = string
      operator = string
      values   = list(string)
    })), [])
    failing_periods = optional(object({
      minimum_failing_periods_to_trigger_alert = number
      number_of_evaluation_periods             = number
    }))
  })
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the Scheduled Query Rule Alert."
  type        = bool
  default     = true
}

################################################################################
# Optional - Configuration
################################################################################

variable "description" {
  description = "The description of the alert."
  type        = string
  default     = null
}

variable "enabled" {
  description = "Whether the alert is enabled."
  type        = bool
  default     = true
}

variable "severity" {
  description = "The severity. Possible values: 0 (Critical), 1 (Error), 2 (Warning), 3 (Informational), 4 (Verbose)."
  type        = number
  default     = 3
}

variable "evaluation_frequency" {
  description = "How often the rule is evaluated. Possible values: PT1M, PT5M, PT10M, PT15M, PT30M, PT45M, PT1H, PT2H, PT3H, PT4H, PT5H, PT6H, P1D."
  type        = string
  default     = "PT5M"
}

variable "window_duration" {
  description = "The period of time on which the alert is evaluated. Possible values: PT1M, PT5M, PT10M, PT15M, PT30M, PT45M, PT1H, PT2H, PT3H, PT4H, PT5H, PT6H, P1D, P2D."
  type        = string
  default     = "PT5M"
}

variable "auto_mitigation_enabled" {
  description = "Whether auto-mitigation is enabled."
  type        = bool
  default     = true
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
