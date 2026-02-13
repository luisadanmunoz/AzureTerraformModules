################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Maintenance Assignment."
  type        = bool
  default     = true
}

variable "location" {
  description = "(Required) The Azure Region where the Maintenance Assignment should exist."
  type        = string
}

################################################################################
# Assignment Configuration
################################################################################

variable "maintenance_configuration_id" {
  description = "(Required) The ID of the Maintenance Configuration. DEPENDENCY: Maintenance Configuration must exist."
  type        = string
}

variable "assignment_type" {
  description = "(Required) Type of assignment. Values: VirtualMachine, DedicatedHost, VirtualMachineScaleSet, DynamicScope."
  type        = string

  validation {
    condition     = contains(["VirtualMachine", "DedicatedHost", "VirtualMachineScaleSet", "DynamicScope"], var.assignment_type)
    error_message = "assignment_type must be one of: VirtualMachine, DedicatedHost, VirtualMachineScaleSet, DynamicScope."
  }
}

################################################################################
# Virtual Machine Assignment
################################################################################

variable "virtual_machine_id" {
  description = "(Optional) The ID of the Virtual Machine. Required when assignment_type is VirtualMachine. DEPENDENCY: VM must exist."
  type        = string
  default     = null
}

################################################################################
# Dedicated Host Assignment
################################################################################

variable "dedicated_host_id" {
  description = "(Optional) The ID of the Dedicated Host. Required when assignment_type is DedicatedHost. DEPENDENCY: Dedicated Host must exist."
  type        = string
  default     = null
}

################################################################################
# Virtual Machine Scale Set Assignment
################################################################################

variable "virtual_machine_scale_set_id" {
  description = "(Optional) The ID of the VMSS. Required when assignment_type is VirtualMachineScaleSet. DEPENDENCY: VMSS must exist."
  type        = string
  default     = null
}

################################################################################
# Dynamic Scope Assignment
################################################################################

variable "dynamic_scope" {
  description = <<-EOT
    (Optional) Dynamic scope configuration for assignment_type DynamicScope.
    - name: Name of the dynamic scope assignment.
    - filter: Filter configuration for targeting resources.
  EOT
  type = object({
    name = string
    filter = object({
      locations       = optional(list(string), [])
      os_types        = optional(list(string), [])
      resource_groups = optional(list(string), [])
      resource_types  = optional(list(string), [])
      tag_filter      = optional(string, null)
      tags = optional(list(object({
        tag    = string
        values = list(string)
      })), [])
    })
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
