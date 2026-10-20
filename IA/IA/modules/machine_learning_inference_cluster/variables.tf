#############################################################################
# VARIABLES MACHINE LEARNING INFERENCE CLUSTER
#############################################################################
variable "machine_learning_inference_cluster_name" {
  description = "value to set the machine learning inference cluster name"
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

variable "kubernetes_cluster_id" {
  description = "value to set the kubernetes cluster id"
  type        = string
}

variable "cluster_purpose" {
  description = "value to set the cluster purpose"
  type        = string
  default     = null
}

variable "description" {
  description = "value to set the description"
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

variable "ssl" {
  description = "value to set the ssl"
  type = object({
    cert                      = optional(string)
    cname                     = optional(string)
    key                       = optional(string)
    leaf_domain_label         = optional(string)
    overwrite_existing_domain = optional(bool)
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
