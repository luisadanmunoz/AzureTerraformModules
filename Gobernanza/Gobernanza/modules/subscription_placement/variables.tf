#############################################################################
# VARIABLES SUBSCRIPTION PLACEMENT
#############################################################################
variable "management_group_id" {
  description = "value to set the management group id"
  type        = string

  validation {
    condition     = length(trim(var.management_group_id, " ")) > 0
    error_message = "management_group_id must not be empty."
  }
}

variable "subscription_id" {
  description = "value to set the subscription id"
  type        = string

  validation {
    condition     = can(regex("^/subscriptions/", var.subscription_id))
    error_message = "subscription_id must start with /subscriptions/."
  }
}
