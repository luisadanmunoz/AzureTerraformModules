#############################################################################
# VARIABLES CONTAINER APP ENVIRONMENT DAPR COMPONENT
#############################################################################
variable "container_app_environment_dapr_component_name" {
  description = "value to set the container app environment dapr component name"
  type        = string
}

variable "container_app_environment_id" {
  description = "value to set the container app environment id"
  type        = string
}

variable "component_type" {
  description = "value to set the component type"
  type        = string
}

variable "component_version" {
  description = "value to set the component version"
  type        = string
}

variable "ignore_errors" {
  description = "value to set the ignore errors flag"
  type        = bool
  default     = null
}

variable "init_timeout" {
  description = "value to set the init timeout"
  type        = string
  default     = null
}

variable "metadata" {
  description = "value to set the metadata"
  type = list(object({
    name        = string
    secret_name = optional(string)
    value       = optional(string)
  }))
  default = null
}

variable "scopes" {
  description = "value to set the scopes"
  type        = list(string)
  default     = null
}

variable "secret" {
  description = "value to set the secret"
  type = list(object({
    name                = string
    value               = optional(string)
    identity            = optional(string)
    key_vault_secret_id = optional(string)
  }))
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
