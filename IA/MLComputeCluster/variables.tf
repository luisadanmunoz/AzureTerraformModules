################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the compute cluster."
  type        = string
}

variable "machine_learning_workspace_id" {
  description = "The ID of the Machine Learning Workspace."
  type        = string
}

variable "location" {
  description = "The Azure region."
  type        = string
}

variable "vm_size" {
  description = "The VM size for cluster nodes."
  type        = string
}

variable "vm_priority" {
  description = "The priority of VMs. Possible values: Dedicated, LowPriority."
  type        = string
  default     = "Dedicated"
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the compute cluster."
  type        = bool
  default     = true
}

################################################################################
# Optional - Scale Settings
################################################################################

variable "min_node_count" {
  description = "Minimum number of nodes."
  type        = number
  default     = 0
}

variable "max_node_count" {
  description = "Maximum number of nodes."
  type        = number
  default     = 4
}

variable "scale_down_nodes_after_idle_duration" {
  description = "Time before idle nodes are scaled down (ISO8601)."
  type        = string
  default     = "PT30M"
}

################################################################################
# Optional - Identity
################################################################################

variable "identity_type" {
  description = "The type of managed identity."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "List of User Assigned Managed Identity IDs."
  type        = list(string)
  default     = []
}

################################################################################
# Optional - Network
################################################################################

variable "subnet_resource_id" {
  description = "The subnet resource ID for the cluster."
  type        = string
  default     = null
}

variable "local_auth_enabled" {
  description = "Whether local authentication is enabled."
  type        = bool
  default     = true
}

variable "node_public_ip_enabled" {
  description = "Whether nodes have public IPs."
  type        = bool
  default     = true
}

################################################################################
# Optional - SSH
################################################################################

variable "ssh_public_access_enabled" {
  description = "Whether SSH public access is enabled."
  type        = bool
  default     = false
}

variable "ssh" {
  description = "SSH configuration."
  type = object({
    admin_username = string
    admin_password = optional(string)
    key_value      = optional(string)
  })
  default = null
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}
