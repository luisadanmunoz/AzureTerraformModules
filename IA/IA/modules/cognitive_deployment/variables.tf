#############################################################################
# VARIABLES COGNITIVE DEPLOYMENT
#############################################################################
variable "cognitive_deployment_name" {
  description = "value to set the cognitive deployment name"
  type        = string
}

variable "cognitive_account_id" {
  description = "value to set the cognitive account id"
  type        = string
}

variable "dynamic_throttling_enabled" {
  description = "value to set the dynamic throttling enabled flag"
  type        = bool
  default     = null
}

variable "rai_policy_name" {
  description = "value to set the rai policy name"
  type        = string
  default     = null
}

variable "version_upgrade_option" {
  description = "value to set the version upgrade option"
  type        = string
  default     = null
}

variable "model" {
  description = "value to set the model"
  type = object({
    format  = string
    name    = string
    version = optional(string)
  })
}

variable "sku" {
  description = "value to set the sku"
  type = object({
    name     = string
    capacity = optional(number)
    family   = optional(string)
    size     = optional(string)
    tier     = optional(string)
  })
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
