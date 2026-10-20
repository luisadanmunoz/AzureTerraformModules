################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the compute instance."
  type        = string
}

variable "machine_learning_workspace_id" {
  description = "The ID of the Machine Learning Workspace."
  type        = string
}

variable "virtual_machine_size" {
  description = "The VM size (e.g., Standard_DS3_v2)."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the compute instance."
  type        = bool
  default     = true
}

################################################################################
# Optional - Configuration
################################################################################

variable "authorization_type" {
  description = "The authorization type. Possible values: personal."
  type        = string
  default     = "personal"
}

variable "description" {
  description = "A description of the compute instance."
  type        = string
  default     = null
}

variable "local_auth_enabled" {
  description = "Whether local authentication is enabled."
  type        = bool
  default     = true
}

variable "node_public_ip_enabled" {
  description = "Whether the compute instance has a public IP."
  type        = bool
  default     = true
}

variable "subnet_resource_id" {
  description = "The subnet resource ID for the compute instance."
  type        = string
  default     = null
}

################################################################################
# Optional - SSH
################################################################################

variable "ssh" {
  description = "SSH configuration for the compute instance."
  type = object({
    public_key = string
  })
  default = null
}

################################################################################
# Optional - Assign To User
################################################################################

variable "assign_to_user" {
  description = "Assign the compute instance to a specific user."
  type = object({
    object_id = string
    tenant_id = string
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
