#############################################################################
# VARIABLES MACHINE LEARNING WORKSPACE NETWORK OUTBOUND RULE FQDN
#############################################################################
variable "machine_learning_workspace_network_outbound_rule_fqdn_name" {
  description = "value to set the machine learning workspace outbound rule fqdn name"
  type        = string
}

variable "workspace_id" {
  description = "value to set the machine learning workspace id"
  type        = string
}

variable "destination_fqdn" {
  description = "value to set the destination fqdn"
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
