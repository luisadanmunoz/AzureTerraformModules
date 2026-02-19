################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Activity Log Alert."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "scopes" {
  description = "List of resource IDs to scope the alert to."
  type        = list(string)
}

variable "criteria" {
  description = "The criteria for the Activity Log Alert."
  type = object({
    category                = string
    operation_name          = optional(string)
    resource_provider       = optional(string)
    resource_type           = optional(string)
    resource_group          = optional(string)
    caller                  = optional(string)
    level                   = optional(string)
    status                  = optional(string)
    sub_status              = optional(string)
    recommendation_type     = optional(string)
    recommendation_category = optional(string)
    recommendation_impact   = optional(string)
  })
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the Activity Log Alert."
  type        = bool
  default     = true
}

################################################################################
# Optional - Configuration
################################################################################

variable "description" {
  description = "The description of the Activity Log Alert."
  type        = string
  default     = null
}

variable "enabled" {
  description = "Whether the Activity Log Alert is enabled."
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
