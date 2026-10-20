#############################################################################
# VARIABLES VIRTUAL DESKTOP WORKSPACE APPLICATION GROUP ASSOCIATION
#############################################################################
variable "workspace_id" {
  description = "value to set the workspace id"
  type        = string
}

variable "application_group_id" {
  description = "value to set the application group id"
  type        = string
}

variable "timeouts" {
  description = "value to set the timeouts"
  type = object({
    create = optional(string)
    read   = optional(string)
    delete = optional(string)
  })
  default = null
}
