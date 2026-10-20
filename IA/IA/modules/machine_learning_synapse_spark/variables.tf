#############################################################################
# VARIABLES MACHINE LEARNING SYNAPSE SPARK
#############################################################################
variable "machine_learning_synapse_spark_name" {
  description = "value to set the machine learning synapse spark name"
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

variable "synapse_spark_pool_id" {
  description = "value to set the synapse spark pool id"
  type        = string
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

variable "identity" {
  description = "value to set the identity"
  type = object({
    type         = string
    identity_ids = optional(list(string))
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
