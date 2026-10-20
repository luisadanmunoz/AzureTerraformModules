#############################################################################
# VARIABLES KUBERNETES CLUSTER EXTENSION
#############################################################################
variable "kubernetes_cluster_extension_name" {
  description = "value to set the kubernetes cluster extension name"
  type        = string
}

variable "cluster_id" {
  description = "value to set the cluster id"
  type        = string
}

variable "extension_type" {
  description = "value to set the extension type"
  type        = string
}

variable "configuration_settings" {
  description = "value to set the configuration settings"
  type        = map(string)
  default     = null
}

variable "configuration_protected_settings" {
  description = "value to set the configuration protected settings"
  type        = map(string)
  default     = null
}

variable "release_namespace" {
  description = "value to set the release namespace"
  type        = string
  default     = null
}

variable "release_train" {
  description = "value to set the release train"
  type        = string
  default     = null
}

variable "target_namespace" {
  description = "value to set the target namespace"
  type        = string
  default     = null
}

variable "extension_version" {
  description = "value to set the extension version"
  type        = string
  default     = null
}

variable "plan" {
  description = "value to set the plan"
  type = object({
    name           = string
    product        = string
    publisher      = string
    promotion_code = optional(string)
    version        = optional(string)
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
