#############################################################################
# VARIABLES COGNITIVE ACCOUNT PROJECT
#############################################################################
variable "cognitive_account_project_name" {
  description = "value to set the cognitive account project name"
  type        = string
}

variable "cognitive_account_id" {
  description = "value to set the cognitive account id"
  type        = string
}

variable "location" {
  description = "value to set the location"
  type        = string
}

variable "description" {
  description = "value to set the description"
  type        = string
  default     = null
}

variable "display_name" {
  description = "value to set the display name"
  type        = string
  default     = null
}

variable "identity" {
  description = "value to set the identity"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
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
