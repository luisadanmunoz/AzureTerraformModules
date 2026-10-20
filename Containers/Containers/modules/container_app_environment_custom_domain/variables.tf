#############################################################################
# VARIABLES CONTAINER APP ENVIRONMENT CUSTOM DOMAIN
#############################################################################
variable "container_app_environment_custom_domain_name" {
  description = "value to set the container app environment custom domain name"
  type        = string
}

variable "container_app_environment_id" {
  description = "value to set the container app environment id"
  type        = string
}

variable "certificate_blob_base64" {
  description = "value to set the certificate blob base64"
  type        = string
}

variable "certificate_password" {
  description = "value to set the certificate password"
  type        = string
  sensitive   = true
}

variable "dns_suffix" {
  description = "value to set the dns suffix"
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
