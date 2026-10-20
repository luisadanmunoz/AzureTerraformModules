#############################################################################
# VARIABLES MACHINE LEARNING COMPUTE INSTANCE
#############################################################################
variable "machine_learning_compute_instance_name" {
  description = "value to set the machine learning compute instance name"
  type        = string
}

variable "machine_learning_workspace_id" {
  description = "value to set the machine learning workspace id"
  type        = string
}

variable "virtual_machine_size" {
  description = "value to set the virtual machine size"
  type        = string
}

variable "authorization_type" {
  description = "value to set the authorization type"
  type        = string
  default     = null
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

variable "subnet_resource_id" {
  description = "value to set the subnet resource id"
  type        = string
  default     = null
}

variable "assign_to_user" {
  description = "value to set the assign to user"
  type = object({
    object_id = optional(string)
    tenant_id = optional(string)
  })
  default = null
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
    public_key = string
  })
  default = null
}

variable "timeouts" {
  description = "value to set the timeouts"
  type = object({
    create = optional(string)
    read   = optional(string)
    delete = optional(string)
  })
  default = null
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
