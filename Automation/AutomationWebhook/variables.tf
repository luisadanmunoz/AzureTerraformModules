################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Automation Webhooks."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group where the Automation Account exists. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "automation_account_name" {
  description = "(Required) The name of the Automation Account. DEPENDENCY: Automation Account must exist."
  type        = string
}

################################################################################
# Webhooks
################################################################################

variable "webhooks" {
  description = <<-EOT
    (Optional) Map of webhooks to create. The key is the webhook name.
    - runbook_name: (Required) The name of the Runbook to trigger. DEPENDENCY: Runbook must exist.
    - expiry_time: (Required) The expiry time in RFC3339 format (e.g., "2025-12-31T23:59:59Z").
    - enabled: (Optional) Whether the webhook is enabled. Default: true.
    - parameters: (Optional) Map of parameters to pass to the Runbook.
    - run_on_worker_group: (Optional) Name of Hybrid Worker Group. DEPENDENCY: Hybrid Worker Group must exist if specified.
    - uri: (Optional) Custom URI for the webhook. If not provided, Azure generates one.
  EOT
  type = map(object({
    runbook_name        = string
    expiry_time         = string
    enabled             = optional(bool, true)
    parameters          = optional(map(string), {})
    run_on_worker_group = optional(string, null)
    uri                 = optional(string, null)
  }))
  default = {}
}
