#############################################################################
# VARIABLES MACHINE LEARNING WORKSPACE NETWORK OUTBOUND RULE PRIVATE ENDPOINT
#############################################################################
variable "machine_learning_workspace_network_outbound_rule_private_endpoint_name" {
  description = "value to set the machine learning workspace outbound rule private endpoint name"
  type        = string
}

variable "workspace_id" {
  description = "value to set the machine learning workspace id"
  type        = string
}

variable "service_resource_id" {
  description = "value to set the service resource id"
  type        = string
}

variable "sub_resource_target" {
  description = "value to set the sub resource target"
  type        = string

  validation {
    condition     = contains(["vault", "amlworkspace", "blob", "table", "queue", "file", "web", "dfs", "redisCache"], var.sub_resource_target)
    error_message = "sub_resource_target must be one of vault, amlworkspace, blob, table, queue, file, web, dfs or redisCache."
  }
}

variable "spark_enabled" {
  description = "value to set the spark enabled flag"
  type        = bool
  default     = null
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
