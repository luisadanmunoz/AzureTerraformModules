################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Automation Modules."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group where the Automation Account exists. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "automation_account_name" {
  description = "(Required) The name of the Automation Account where the Modules will be imported. DEPENDENCY: Automation Account must exist."
  type        = string
}

################################################################################
# PowerShell Modules
################################################################################

variable "modules" {
  description = <<-EOT
    (Optional) Map of PowerShell modules to import. The key is the module name.
    - uri: (Required) The URI to the module package (.zip or .nupkg).
           For PowerShell Gallery: https://www.powershellgallery.com/api/v2/package/{ModuleName}/{Version}
    - version: (Optional) Version string for documentation/tracking purposes.
    - hash: (Optional) Hash configuration for content validation.
      - algorithm: Hash algorithm (e.g., SHA256).
      - value: The hash value.
  EOT
  type = map(object({
    uri     = string
    version = optional(string, null)
    hash = optional(object({
      algorithm = string
      value     = string
    }), null)
  }))
  default = {}
}

################################################################################
# PowerShell Gallery Modules (Convenience)
################################################################################

variable "powershell_gallery_modules" {
  description = <<-EOT
    (Optional) Map of modules to import from PowerShell Gallery. The key is the module name.
    - version: (Required) The version of the module to import.
    Note: This is a convenience variable that auto-generates the PowerShell Gallery URI.
  EOT
  type = map(object({
    version = string
  }))
  default = {}
}
