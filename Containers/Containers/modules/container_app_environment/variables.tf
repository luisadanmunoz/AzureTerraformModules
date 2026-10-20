#############################################################################
# VARIABLES CONTAINER APP ENVIRONMENT
#############################################################################
variable "container_app_environment_name" {
  description = "value to set the container app environment name"
  type        = string
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "location" {
  description = "value to set the location"
  type        = string
}

variable "dapr_application_insights_connection_string" {
  description = "value to set the dapr application insights connection string"
  type        = string
  default     = null
}

variable "infrastructure_resource_group_name" {
  description = "value to set the infrastructure resource group name"
  type        = string
  default     = null
}

variable "infrastructure_subnet_id" {
  description = "value to set the infrastructure subnet id"
  type        = string
  default     = null
}

variable "internal_load_balancer_enabled" {
  description = "value to set the internal load balancer enabled flag"
  type        = bool
  default     = null
}

variable "log_analytics_workspace_id" {
  description = "value to set the log analytics workspace id"
  type        = string
  default     = null
}

variable "logs_destination" {
  description = "value to set the logs destination"
  type        = string
  default     = null
}

variable "mutual_tls_enabled" {
  description = "value to set the mutual tls enabled flag"
  type        = bool
  default     = null
}

variable "public_network_access" {
  description = "value to set the public network access"
  type        = string
  default     = null
}

variable "zone_redundancy_enabled" {
  description = "value to set the zone redundancy enabled flag"
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

variable "workload_profile" {
  description = "value to set the workload profile"
  type = list(object({
    name                  = string
    workload_profile_type = string
    maximum_count         = optional(number)
    minimum_count         = optional(number)
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

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
