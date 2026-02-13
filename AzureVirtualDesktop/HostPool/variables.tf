################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the AVD Host Pool."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Host Pool should exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Optional) The name of the Host Pool. If not provided, a name will be generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for the generated name. Default: 'vdpool'."
  type        = string
  default     = "vdpool"
}

variable "workload" {
  description = "(Optional) Workload name for the naming convention."
  type        = string
  default     = "avd"
}

variable "environment" {
  description = "(Optional) Environment name (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "instance" {
  description = "(Optional) Instance number for the naming convention."
  type        = string
  default     = "001"
}

################################################################################
# Host Pool Configuration
################################################################################

variable "type" {
  description = "(Required) The type of the Host Pool. Values: Personal, Pooled."
  type        = string

  validation {
    condition     = contains(["Personal", "Pooled"], var.type)
    error_message = "type must be either 'Personal' or 'Pooled'."
  }
}

variable "load_balancer_type" {
  description = "(Required) The load balancer type. Values: BreadthFirst, DepthFirst, Persistent."
  type        = string

  validation {
    condition     = contains(["BreadthFirst", "DepthFirst", "Persistent"], var.load_balancer_type)
    error_message = "load_balancer_type must be BreadthFirst, DepthFirst, or Persistent."
  }
}

variable "friendly_name" {
  description = "(Optional) A friendly name for the Host Pool."
  type        = string
  default     = null
}

variable "description" {
  description = "(Optional) A description for the Host Pool."
  type        = string
  default     = null
}

variable "validate_environment" {
  description = "(Optional) Whether to validate the environment. Default: false."
  type        = bool
  default     = false
}

variable "start_vm_on_connect" {
  description = "(Optional) Enables Start VM on Connect. Default: false."
  type        = bool
  default     = false
}

variable "custom_rdp_properties" {
  description = "(Optional) Custom RDP properties string."
  type        = string
  default     = null
}

variable "personal_desktop_assignment_type" {
  description = "(Optional) Personal desktop assignment type. Values: Automatic, Direct. Required for Personal pools."
  type        = string
  default     = null

  validation {
    condition     = var.personal_desktop_assignment_type == null || contains(["Automatic", "Direct"], var.personal_desktop_assignment_type)
    error_message = "personal_desktop_assignment_type must be Automatic or Direct."
  }
}

variable "maximum_sessions_allowed" {
  description = "(Optional) Maximum concurrent sessions per host. Required for Pooled pools."
  type        = number
  default     = null
}

variable "preferred_app_group_type" {
  description = "(Optional) Preferred Application Group type. Values: Desktop, RailApplications. Default: Desktop."
  type        = string
  default     = "Desktop"

  validation {
    condition     = contains(["Desktop", "RailApplications", "None"], var.preferred_app_group_type)
    error_message = "preferred_app_group_type must be Desktop, RailApplications, or None."
  }
}

################################################################################
# Registration Info
################################################################################

variable "registration_expiration_date" {
  description = "(Optional) The expiration date for the registration token in RFC3339 format."
  type        = string
  default     = null
}

################################################################################
# Scheduled Agent Updates
################################################################################

variable "scheduled_agent_updates" {
  description = <<-EOT
    (Optional) Scheduled agent updates configuration.
    - enabled: Whether scheduled updates are enabled.
    - timezone: Timezone for the schedule.
    - use_session_host_timezone: Use session host's timezone.
    - schedule: List of schedules with day_of_week and hour_of_day.
  EOT
  type = object({
    enabled                   = optional(bool, true)
    timezone                  = optional(string, "UTC")
    use_session_host_timezone = optional(bool, false)
    schedule = optional(list(object({
      day_of_week = string
      hour_of_day = number
    })), [])
  })
  default = null
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
