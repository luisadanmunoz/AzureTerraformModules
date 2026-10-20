#############################################################################
# VARIABLES CONTAINER APP ENVIRONMENT CERTIFICATE
#############################################################################
variable "container_app_environment_certificate_name" {
  description = "value to set the container app environment certificate name"
  type        = string
}

variable "container_app_environment_id" {
  description = "value to set the container app environment id"
  type        = string
}

variable "certificate_blob_base64" {
  description = "value to set the certificate blob base64"
  type        = string
  default     = null
}

variable "certificate_password" {
  description = "value to set the certificate password"
  type        = string
  default     = null
  sensitive   = true
}

variable "certificate_key_vault" {
  description = "value to set the certificate key vault configuration"
  type = object({
    identity            = optional(string)
    key_vault_secret_id = string
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

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
