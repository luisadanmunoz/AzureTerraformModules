#############################################################################
# VARIABLES BUDGET
#############################################################################
variable "budget_name" {
  description = "value to set the budget name"
  type        = string

  validation {
    condition     = length(trim(var.budget_name, " ")) > 0
    error_message = "budget_name must not be empty."
  }
}

variable "scope_type" {
  description = "value to set the scope type"
  type        = string

  validation {
    condition     = contains(["management_group", "subscription", "resource_group"], var.scope_type)
    error_message = "scope_type must be management_group, subscription, or resource_group."
  }
}

variable "amount" {
  description = "value to set the amount"
  type        = number
}

variable "time_grain" {
  description = "value to set the time grain"
  type        = string

  validation {
    condition     = contains(["BillingMonth", "BillingQuarter", "Annually", "Monthly", "Quarterly"], var.time_grain)
    error_message = "time_grain must be BillingMonth, BillingQuarter, Annually, Monthly, or Quarterly."
  }
}

variable "start_date" {
  description = "value to set the start date"
  type        = string
}

variable "end_date" {
  description = "value to set the end date"
  type        = string
  default     = null
}

variable "management_group_id" {
  description = "value to set the management group id"
  type        = string
  default     = null
}

variable "subscription_id" {
  description = "value to set the subscription id"
  type        = string
  default     = null
}

variable "resource_group_id" {
  description = "value to set the resource group id"
  type        = string
  default     = null
}

variable "notifications" {
  description = "value to set the notifications"
  type = map(object({
    enabled        = bool
    operator       = string
    threshold      = number
    threshold_type = optional(string)
    contact_emails = optional(list(string))
  }))
  default = {}
}
