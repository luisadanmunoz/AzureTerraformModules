#############################################################################
# VARIABLES KUBERNETES FLEET MEMBER
#############################################################################
variable "kubernetes_fleet_member_name" {
  description = "value to set the kubernetes fleet member name"
  type        = string
}

variable "kubernetes_fleet_id" {
  description = "value to set the kubernetes fleet id"
  type        = string
}

variable "kubernetes_cluster_id" {
  description = "value to set the kubernetes cluster id"
  type        = string
}

variable "group" {
  description = "value to set the group"
  type        = string
  default     = null
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
