#############################################################################
# VARIABLES MACHINE LEARNING WORKSPACE NETWORK OUTBOUND RULE SERVICE TAG
#############################################################################
variable "machine_learning_workspace_network_outbound_rule_service_tag_name" {
  description = "value to set the machine learning workspace outbound rule service tag name"
  type        = string
}

variable "workspace_id" {
  description = "value to set the machine learning workspace id"
  type        = string
}

variable "service_tag" {
  description = "value to set the service tag"
  type        = string
}

variable "protocol" {
  description = "value to set the protocol"
  type        = string

  validation {
    condition     = contains(["*", "TCP", "UDP", "ICMP"], var.protocol)
    error_message = "protocol must be one of *, TCP, UDP or ICMP."
  }
}

variable "port_ranges" {
  description = "value to set the port ranges"
  type        = string
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
