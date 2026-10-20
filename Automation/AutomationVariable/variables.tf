################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Automation Variables."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group where the Automation Account exists. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "automation_account_name" {
  description = "(Required) The name of the Automation Account where the Variables will be created. DEPENDENCY: Automation Account must exist."
  type        = string
}

################################################################################
# String Variables
################################################################################

variable "string_variables" {
  description = <<-EOT
    (Optional) Map of string variables to create.
    - value: (Required) The value of the variable.
    - description: (Optional) Description of the variable.
    - encrypted: (Optional) Whether the variable is encrypted. Default: false.
  EOT
  type = map(object({
    value       = string
    description = optional(string, null)
    encrypted   = optional(bool, false)
  }))
  default = {}
}

################################################################################
# Integer Variables
################################################################################

variable "int_variables" {
  description = <<-EOT
    (Optional) Map of integer variables to create.
    - value: (Required) The integer value of the variable.
    - description: (Optional) Description of the variable.
    - encrypted: (Optional) Whether the variable is encrypted. Default: false.
  EOT
  type = map(object({
    value       = number
    description = optional(string, null)
    encrypted   = optional(bool, false)
  }))
  default = {}
}

################################################################################
# Boolean Variables
################################################################################

variable "bool_variables" {
  description = <<-EOT
    (Optional) Map of boolean variables to create.
    - value: (Required) The boolean value of the variable.
    - description: (Optional) Description of the variable.
    - encrypted: (Optional) Whether the variable is encrypted. Default: false.
  EOT
  type = map(object({
    value       = bool
    description = optional(string, null)
    encrypted   = optional(bool, false)
  }))
  default = {}
}

################################################################################
# DateTime Variables
################################################################################

variable "datetime_variables" {
  description = <<-EOT
    (Optional) Map of datetime variables to create.
    - value: (Required) The datetime value in RFC3339 format (e.g., "2024-01-01T00:00:00Z").
    - description: (Optional) Description of the variable.
    - encrypted: (Optional) Whether the variable is encrypted. Default: false.
  EOT
  type = map(object({
    value       = string
    description = optional(string, null)
    encrypted   = optional(bool, false)
  }))
  default = {}
}

################################################################################
# Object/JSON Variables (stored as string)
################################################################################

variable "object_variables" {
  description = <<-EOT
    (Optional) Map of object/JSON variables to create. Values are JSON-encoded.
    - value: (Required) The object value (will be JSON encoded).
    - description: (Optional) Description of the variable.
    - encrypted: (Optional) Whether the variable is encrypted. Default: false.
  EOT
  type = map(object({
    value       = any
    description = optional(string, null)
    encrypted   = optional(bool, false)
  }))
  default = {}
}
