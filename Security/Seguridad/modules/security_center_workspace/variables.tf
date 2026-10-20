#############################################################################
# VARIABLES SECURITY CENTER WORKSPACE
#############################################################################
variable "scope" {
  description = "value to set the scope"
  type        = string
}

variable "workspace_id" {
  description = "value to set the workspace id"
  type        = string
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
