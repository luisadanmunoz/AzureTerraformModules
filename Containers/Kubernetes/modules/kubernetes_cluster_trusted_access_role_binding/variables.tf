#############################################################################
# VARIABLES KUBERNETES CLUSTER TRUSTED ACCESS ROLE BINDING
#############################################################################
variable "kubernetes_cluster_trusted_access_role_binding_name" {
  description = "value to set the kubernetes cluster trusted access role binding name"
  type        = string
}

variable "kubernetes_cluster_id" {
  description = "value to set the kubernetes cluster id"
  type        = string
}

variable "roles" {
  description = "value to set the roles"
  type        = list(string)
}

variable "source_resource_id" {
  description = "value to set the source resource id"
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
