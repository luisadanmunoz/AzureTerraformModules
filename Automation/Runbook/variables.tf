################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Runbook."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group where the Automation Account exists. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Runbook should exist."
  type        = string
}

variable "automation_account_name" {
  description = "(Required) The name of the Automation Account where the Runbook will be created. DEPENDENCY: Automation Account must exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Required) The name of the Runbook."
  type        = string
}

################################################################################
# Runbook Configuration
################################################################################

variable "runbook_type" {
  description = "(Required) The type of the Runbook. Possible values: PowerShell, PowerShellWorkflow, Python2, Python3, Graph, GraphPowerShell, GraphPowerShellWorkflow, PowerShell72."
  type        = string

  validation {
    condition     = contains(["PowerShell", "PowerShellWorkflow", "Python2", "Python3", "Graph", "GraphPowerShell", "GraphPowerShellWorkflow", "PowerShell72"], var.runbook_type)
    error_message = "runbook_type must be one of: PowerShell, PowerShellWorkflow, Python2, Python3, Graph, GraphPowerShell, GraphPowerShellWorkflow, PowerShell72."
  }
}

variable "description" {
  description = "(Optional) A description for this Runbook."
  type        = string
  default     = null
}

variable "log_verbose" {
  description = "(Optional) Enable verbose logging. Default: false."
  type        = bool
  default     = false
}

variable "log_progress" {
  description = "(Optional) Enable progress logging. Default: false."
  type        = bool
  default     = false
}

variable "log_activity_trace_level" {
  description = "(Optional) The activity-level tracing for this Runbook. Possible values: 0 (disabled), 1-99."
  type        = number
  default     = 0

  validation {
    condition     = var.log_activity_trace_level >= 0 && var.log_activity_trace_level <= 99
    error_message = "log_activity_trace_level must be between 0 and 99."
  }
}

################################################################################
# Runbook Content
################################################################################

variable "content" {
  description = "(Optional) The inline content of the Runbook script. Conflicts with publish_content_link."
  type        = string
  default     = null
}

variable "publish_content_link" {
  description = <<-EOT
    (Optional) Publish content from a URI. Conflicts with content.
    - uri: (Required) The URI of the Runbook content.
    - version: (Optional) The version of the content.
    - hash: (Optional) Hash configuration for validation.
      - algorithm: Hash algorithm (e.g., SHA256).
      - value: The hash value.
  EOT
  type = object({
    uri     = string
    version = optional(string, null)
    hash = optional(object({
      algorithm = string
      value     = string
    }), null)
  })
  default = null
}

################################################################################
# Draft Configuration
################################################################################

variable "draft" {
  description = <<-EOT
    (Optional) Draft configuration for unpublished Runbook.
    - edit_mode_enabled: (Optional) Enable edit mode.
    - content_link: (Optional) Content link for draft.
    - output_types: (Optional) List of output types.
    - parameters: (Optional) List of parameters with name, type, mandatory, position, default_value.
  EOT
  type = object({
    edit_mode_enabled = optional(bool, false)
    content_link = optional(object({
      uri     = string
      version = optional(string, null)
      hash = optional(object({
        algorithm = string
        value     = string
      }), null)
    }), null)
    output_types = optional(list(string), [])
    parameters = optional(list(object({
      key           = string
      type          = string
      mandatory     = optional(bool, false)
      position      = optional(number, null)
      default_value = optional(string, null)
    })), [])
  })
  default = null
}

################################################################################
# Job Schedules
################################################################################

variable "job_schedules" {
  description = <<-EOT
    (Optional) List of schedules to associate with this Runbook.
    - schedule_name: (Required) The name of the Schedule. DEPENDENCY: Schedule must exist.
    - parameters: (Optional) Map of parameters to pass to the Runbook.
    - run_on: (Optional) Name of Hybrid Worker Group to run on.
  EOT
  type = list(object({
    schedule_name = string
    parameters    = optional(map(string), {})
    run_on        = optional(string, null)
  }))
  default = []
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
