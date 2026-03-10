################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the DSC Configurations."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group where the Automation Account exists. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the DSC Configuration should exist."
  type        = string
}

variable "automation_account_name" {
  description = "(Required) The name of the Automation Account. DEPENDENCY: Automation Account must exist."
  type        = string
}

################################################################################
# DSC Configurations
################################################################################

variable "configurations" {
  description = <<-EOT
    (Optional) Map of DSC Configurations to create. The key is the configuration name.
    - content_embedded: (Optional) The PowerShell DSC Configuration script content (inline).
    - content_uri: (Optional) URI to the DSC Configuration script. Conflicts with content_embedded.
    - description: (Optional) Description of the configuration.
    - log_verbose: (Optional) Enable verbose logging. Default: false.
    Note: Either content_embedded or content_uri must be specified.
  EOT
  type = map(object({
    content_embedded = optional(string, null)
    content_uri      = optional(string, null)
    description      = optional(string, null)
    log_verbose      = optional(bool, false)
  }))
  default = {}

  validation {
    condition = alltrue([
      for name, config in var.configurations :
      (config.content_embedded != null || config.content_uri != null) &&
      !(config.content_embedded != null && config.content_uri != null)
    ])
    error_message = "Each configuration must specify either 'content_embedded' or 'content_uri', but not both."
  }
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
