#############################################################################
# VARIABLES MACHINE LEARNING COMPUTE CLUSTER
#############################################################################
variable "machine_learning_compute_cluster_name" {
  description = "value to set the machine learning compute cluster name"
  type        = string
}

variable "machine_learning_workspace_id" {
  description = "value to set the machine learning workspace id"
  type        = string
}

variable "location" {
  description = "value to set the location"
  type        = string
}

variable "vm_priority" {
  description = "value to set the vm priority"
  type        = string
}

variable "vm_size" {
  description = "value to set the vm size"
  type        = string
}

variable "scale_settings" {
  description = "value to set the scale settings"
  type = object({
    max_node_count                       = number
    min_node_count                       = number
    scale_down_nodes_after_idle_duration = string
  })
}

variable "description" {
  description = "value to set the description"
  type        = string
  default     = null
}

variable "local_auth_enabled" {
  description = "value to set the local auth enabled flag"
  type        = bool
  default     = null
}

variable "node_public_ip_enabled" {
  description = "value to set the node public ip enabled flag"
  type        = bool
  default     = null
}

variable "ssh_public_access_enabled" {
  description = "value to set the ssh public access enabled flag"
  type        = bool
  default     = null
}

variable "subnet_resource_id" {
  description = "value to set the subnet resource id"
  type        = string
  default     = null
}

variable "identity" {
  description = "value to set the identity"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "ssh" {
  description = "value to set the ssh"
  type = object({
    admin_username = string
    admin_password = optional(string)
    key_value      = optional(string)
  })
  default = null
}

variable "timeouts" {
  description = "value to set the timeouts"
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
