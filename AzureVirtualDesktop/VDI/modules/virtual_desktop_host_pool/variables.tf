#############################################################################
# VARIABLES VIRTUAL DESKTOP HOST POOL
#############################################################################
variable "virtual_desktop_host_pool_name" {
  description = "value to set the virtual desktop host pool name"
  type        = string
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "location" {
  description = "value to set the location"
  type        = string
}

variable "type" {
  description = "value to set the host pool type"
  type        = string

  validation {
    condition     = contains(["Personal", "Pooled"], var.type)
    error_message = "type must be Personal or Pooled."
  }
}

variable "load_balancer_type" {
  description = "value to set the load balancer type"
  type        = string

  validation {
    condition     = contains(["BreadthFirst", "DepthFirst", "Persistent"], var.load_balancer_type)
    error_message = "load_balancer_type must be BreadthFirst, DepthFirst or Persistent."
  }
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

variable "validate_environment" {
  description = "value to set the validate environment flag"
  type        = bool
  default     = null
}

variable "start_vm_on_connect" {
  description = "value to set the start vm on connect flag"
  type        = bool
  default     = null
}

variable "custom_rdp_properties" {
  description = "value to set the custom rdp properties"
  type        = string
  default     = null
}

variable "personal_desktop_assignment_type" {
  description = "value to set the personal desktop assignment type"
  type        = string
  default     = null
}

variable "public_network_access" {
  description = "value to set the public network access"
  type        = string
  default     = null
}

variable "maximum_sessions_allowed" {
  description = "value to set the maximum sessions allowed"
  type        = number
  default     = null
}

variable "preferred_app_group_type" {
  description = "value to set the preferred app group type"
  type        = string
  default     = null
}

variable "vm_template" {
  description = "value to set the vm template"
  type        = string
  default     = null
}

variable "scheduled_agent_updates" {
  description = "value to set the scheduled agent updates"
  type = object({
    enabled                   = optional(bool)
    timezone                  = optional(string)
    use_session_host_timezone = optional(bool)
    schedule = optional(list(object({
      day_of_week = string
      hour_of_day = number
    })))
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
