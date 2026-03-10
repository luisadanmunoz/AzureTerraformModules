################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Logic App."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Logic App should exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Optional) The name of the Logic App. If not provided, a name will be generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for the generated name. Default: 'logic'."
  type        = string
  default     = "logic"
}

variable "workload" {
  description = "(Optional) Workload name for the naming convention."
  type        = string
  default     = "app"
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
# Logic App Configuration
################################################################################

variable "enabled" {
  description = "(Optional) Whether the Logic App is enabled. Default: true."
  type        = bool
  default     = true
}

variable "workflow_schema" {
  description = "(Optional) The Schema URI for the workflow definition."
  type        = string
  default     = "https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#"
}

variable "workflow_version" {
  description = "(Optional) The version of the workflow schema."
  type        = string
  default     = "1.0.0.0"
}

variable "workflow_parameters" {
  description = "(Optional) Map of workflow parameters in JSON format."
  type        = map(string)
  default     = {}
}

variable "parameters" {
  description = "(Optional) Map of parameters for the workflow definition."
  type        = map(string)
  default     = {}
}

variable "workflow_definition" {
  description = "(Optional) The JSON-encoded workflow definition. If not provided, an empty workflow is created."
  type        = string
  default     = null
}

################################################################################
# Integration Account
################################################################################

variable "integration_service_environment_id" {
  description = "(Optional) The ID of the Integration Service Environment. DEPENDENCY: ISE must exist."
  type        = string
  default     = null
}

variable "logic_app_integration_account_id" {
  description = "(Optional) The ID of the Logic App Integration Account. DEPENDENCY: Integration Account must exist."
  type        = string
  default     = null
}

################################################################################
# Identity
################################################################################

variable "identity" {
  description = <<-EOT
    (Optional) Identity configuration for the Logic App.
    - type: (Required) Type of identity. Possible values: SystemAssigned, UserAssigned, SystemAssigned, UserAssigned.
    - identity_ids: (Optional) List of User Assigned Identity IDs. DEPENDENCY: User Assigned Identities must exist.
  EOT
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = null

  validation {
    condition     = var.identity == null || contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity.type)
    error_message = "identity.type must be one of: SystemAssigned, UserAssigned, 'SystemAssigned, UserAssigned'."
  }
}

################################################################################
# Access Control
################################################################################

variable "access_control" {
  description = <<-EOT
    (Optional) Access control configuration for triggers, contents, and actions.
    - trigger: (Optional) Access control for triggers with allowed_caller_ip_address_range list.
    - content: (Optional) Access control for contents with allowed_caller_ip_address_range list.
    - action: (Optional) Access control for actions with allowed_caller_ip_address_range list.
    - workflow_management: (Optional) Access control for workflow management with allowed_caller_ip_address_range list.
  EOT
  type = object({
    trigger = optional(object({
      allowed_caller_ip_address_range = list(string)
    }), null)
    content = optional(object({
      allowed_caller_ip_address_range = list(string)
    }), null)
    action = optional(object({
      allowed_caller_ip_address_range = list(string)
    }), null)
    workflow_management = optional(object({
      allowed_caller_ip_address_range = list(string)
    }), null)
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
