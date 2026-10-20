################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Hybrid Worker Groups."
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
# Hybrid Worker Groups
################################################################################

variable "hybrid_worker_groups" {
  description = <<-EOT
    (Optional) Map of Hybrid Worker Groups to create. The key is the group name.
    - credential_name: (Optional) The name of the credential to use for the Hybrid Workers. DEPENDENCY: Credential must exist in the Automation Account.
  EOT
  type = map(object({
    credential_name = optional(string, null)
  }))
  default = {}
}

################################################################################
# Hybrid Workers (Azure VMs)
################################################################################

variable "hybrid_workers" {
  description = <<-EOT
    (Optional) Map of Hybrid Workers (Azure VMs) to add to groups. The key is a unique identifier.
    - group_name: (Required) The name of the Hybrid Worker Group. Must match a key in hybrid_worker_groups or existing group.
    - vm_resource_id: (Required) The Azure Resource ID of the VM. DEPENDENCY: VM must exist with Hybrid Worker extension.
  EOT
  type = map(object({
    group_name     = string
    vm_resource_id = string
  }))
  default = {}
}
