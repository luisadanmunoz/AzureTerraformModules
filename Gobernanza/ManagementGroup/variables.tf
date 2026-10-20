################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the management group."
  type        = string
}

variable "display_name" {
  description = "The display name of the management group."
  type        = string
}

################################################################################
# Optional Variables - Configuration
################################################################################

variable "create" {
  description = "Controls whether resources should be created."
  type        = bool
  default     = true
}

# DEPENDENCY: Parent Management Group must exist if specified
variable "parent_management_group_id" {
  description = "The ID of the parent Management Group. If null, will be created under the tenant root group."
  type        = string
  default     = null
}

################################################################################
# Optional Variables - Subscriptions
################################################################################

# DEPENDENCY: Subscriptions must exist
variable "subscription_ids" {
  description = "List of subscription IDs to associate with this management group."
  type        = list(string)
  default     = []
}
