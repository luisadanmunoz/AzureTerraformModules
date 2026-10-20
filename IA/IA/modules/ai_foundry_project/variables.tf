#############################################################################
# VARIABLES AI FOUNDRY PROJECT
#############################################################################
variable "ai_foundry_project_name" {
  description = "value to set the ai foundry project name"
  type        = string
}

variable "location" {
  description = "value to set the location"
  type        = string
}

variable "ai_services_hub_id" {
  description = "value to set the ai services hub id"
  type        = string
}

variable "description" {
  description = "value to set the description"
  type        = string
  default     = null
}

variable "friendly_name" {
  description = "value to set the friendly name"
  type        = string
  default     = null
}

variable "high_business_impact_enabled" {
  description = "value to set the high business impact enabled flag"
  type        = bool
  default     = null
}

variable "primary_user_assigned_identity" {
  description = "value to set the primary user assigned identity"
  type        = string
  default     = null
}

variable "identity" {
  description = "value to set the identity"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
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

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
