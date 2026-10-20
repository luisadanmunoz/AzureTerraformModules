#############################################################################
# VARIABLES CONTAINER APP CUSTOM DOMAIN
#############################################################################
variable "container_app_custom_domain_name" {
  description = "value to set the container app custom domain name"
  type        = string
}

variable "container_app_id" {
  description = "value to set the container app id"
  type        = string
}

variable "container_app_environment_certificate_id" {
  description = "value to set the container app environment certificate id"
  type        = string
  default     = null
}

variable "certificate_binding_type" {
  description = "value to set the certificate binding type"
  type        = string
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
