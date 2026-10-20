################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Shared Image Gallery."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Gallery should exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Optional) The name of the Gallery. Must be unique. Only alphanumeric, underscores, periods allowed."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for the generated name. Default: 'gal'."
  type        = string
  default     = "gal"
}

variable "workload" {
  description = "(Optional) Workload name for the naming convention."
  type        = string
  default     = "images"
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
# Gallery Configuration
################################################################################

variable "description" {
  description = "(Optional) A description for the Shared Image Gallery."
  type        = string
  default     = null
}

variable "sharing" {
  description = <<-EOT
    (Optional) Sharing configuration.
    - permission: Sharing permission. Values: Community, Groups, Private. Default: Private.
    - community_gallery: Community gallery configuration (for Community permission).
  EOT
  type = object({
    permission = optional(string, "Private")
    community_gallery = optional(object({
      eula            = string
      prefix          = string
      publisher_email = string
      publisher_uri   = string
    }), null)
  })
  default = {}
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
