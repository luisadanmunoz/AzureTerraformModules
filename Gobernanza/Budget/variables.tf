################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the budget."
  type        = string
}

variable "amount" {
  description = "The budget amount."
  type        = number
}

variable "time_grain" {
  description = "The time grain for the budget. Possible values are BillingAnnual, BillingMonth, BillingQuarter, Annually, Monthly, Quarterly."
  type        = string
  default     = "Monthly"

  validation {
    condition     = contains(["BillingAnnual", "BillingMonth", "BillingQuarter", "Annually", "Monthly", "Quarterly"], var.time_grain)
    error_message = "Invalid time grain value."
  }
}

variable "time_period" {
  description = "The time period for the budget."
  type = object({
    start_date = string
    end_date   = optional(string)
  })
}

################################################################################
# Optional Variables - Configuration
################################################################################

variable "create" {
  description = "Controls whether resources should be created."
  type        = bool
  default     = true
}

################################################################################
# Optional Variables - Scope
################################################################################

variable "scope_type" {
  description = "The type of scope for the budget: subscription, resource_group, or management_group."
  type        = string
  default     = "subscription"

  validation {
    condition     = contains(["subscription", "resource_group", "management_group"], var.scope_type)
    error_message = "Scope type must be subscription, resource_group, or management_group."
  }
}

# DEPENDENCY: Resource Group must exist if scope_type is resource_group
variable "resource_group_id" {
  description = "The ID of the Resource Group for the budget (when scope_type is resource_group)."
  type        = string
  default     = null
}

# DEPENDENCY: Subscription must exist if scope_type is subscription
variable "subscription_id" {
  description = "The ID of the Subscription for the budget (when scope_type is subscription). Uses current if null."
  type        = string
  default     = null
}

# DEPENDENCY: Management Group must exist if scope_type is management_group
variable "management_group_id" {
  description = "The ID of the Management Group for the budget (when scope_type is management_group)."
  type        = string
  default     = null
}

################################################################################
# Optional Variables - Notifications
################################################################################

variable "notifications" {
  description = "List of budget notifications."
  type = list(object({
    enabled        = optional(bool, true)
    threshold      = number
    threshold_type = optional(string, "Actual")
    operator       = string
    contact_emails = optional(list(string), [])
    contact_groups = optional(list(string), [])
    contact_roles  = optional(list(string), [])
  }))
  default = []

  validation {
    condition = alltrue([
      for n in var.notifications : contains(["Actual", "Forecasted"], n.threshold_type)
    ])
    error_message = "Threshold type must be Actual or Forecasted."
  }

  validation {
    condition = alltrue([
      for n in var.notifications : contains(["EqualTo", "GreaterThan", "GreaterThanOrEqualTo"], n.operator)
    ])
    error_message = "Operator must be EqualTo, GreaterThan, or GreaterThanOrEqualTo."
  }
}

################################################################################
# Optional Variables - Filters
################################################################################

variable "filter" {
  description = "Filter configuration for the budget."
  type = object({
    dimensions = optional(list(object({
      name   = string
      values = list(string)
    })), [])
    tags = optional(list(object({
      name   = string
      values = list(string)
    })), [])
  })
  default = null
}
