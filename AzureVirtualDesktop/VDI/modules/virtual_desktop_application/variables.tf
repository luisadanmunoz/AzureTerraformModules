#############################################################################
# VARIABLES VIRTUAL DESKTOP APPLICATION
#############################################################################
variable "virtual_desktop_application_name" {
  description = "value to set the virtual desktop application name"
  type        = string
}

variable "application_group_id" {
  description = "value to set the application group id"
  type        = string
}

variable "friendly_name" {
  description = "value to set the friendly name"
  type        = string
  default     = null
}

variable "description" {
  description = "value to set the description"
  type        = string
  default     = null
}

variable "path" {
  description = "value to set the path"
  type        = string
}

variable "command_line_argument_policy" {
  description = "value to set the command line argument policy"
  type        = string

  validation {
    condition     = contains(["DoNotAllow", "Allow", "Require"], var.command_line_argument_policy)
    error_message = "command_line_argument_policy must be DoNotAllow, Allow or Require."
  }
}

variable "command_line_arguments" {
  description = "value to set the command line arguments"
  type        = string
  default     = null
}

variable "show_in_portal" {
  description = "value to set the show in portal flag"
  type        = bool
  default     = null
}

variable "icon_path" {
  description = "value to set the icon path"
  type        = string
  default     = null
}

variable "icon_index" {
  description = "value to set the icon index"
  type        = number
  default     = null
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
