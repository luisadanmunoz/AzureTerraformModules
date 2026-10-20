################################################################################
# Required Variables
################################################################################

variable "resource_group_name" {
  description = "The name of the resource group where the Container App Environment will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the Container App Environment will be created."
  type        = string
}

################################################################################
# Optional Variables - Naming
################################################################################

variable "name" {
  description = "The name of the Container App Environment. If not provided, will be generated from naming variables."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix for the Container App Environment name."
  type        = string
  default     = "cae"
}

variable "workload" {
  description = "The workload name for naming convention."
  type        = string
  default     = ""
}

variable "environment" {
  description = "The environment name (dev, staging, prod) for naming convention."
  type        = string
  default     = ""
}

variable "instance" {
  description = "The instance identifier for naming convention."
  type        = string
  default     = "001"
}

################################################################################
# Optional Variables - Configuration
################################################################################

variable "create" {
  description = "Controls whether resources should be created."
  type        = bool
  default     = true
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace for monitoring."
  type        = string
  default     = null
}

variable "infrastructure_subnet_id" {
  description = "The ID of the subnet for the Container App Environment infrastructure."
  type        = string
  default     = null
}

variable "internal_load_balancer_enabled" {
  description = "Whether the Container App Environment should be deployed with an internal load balancer."
  type        = bool
  default     = false
}

variable "zone_redundancy_enabled" {
  description = "Whether the Container App Environment should be zone redundant."
  type        = bool
  default     = false
}

variable "dapr_application_insights_connection_string" {
  description = "Application Insights connection string for Dapr."
  type        = string
  default     = null
  sensitive   = true
}

variable "infrastructure_resource_group_name" {
  description = "Name of the resource group for infrastructure resources. If not set, a generated name will be used."
  type        = string
  default     = null
}

################################################################################
# Optional Variables - Workload Profiles
################################################################################

variable "workload_profiles" {
  description = "List of workload profiles for the Container App Environment."
  type = list(object({
    name                  = string
    workload_profile_type = string
    minimum_count         = optional(number, 0)
    maximum_count         = optional(number, 0)
  }))
  default = []

  validation {
    condition = alltrue([
      for wp in var.workload_profiles :
      contains(["Consumption", "D4", "D8", "D16", "D32", "E4", "E8", "E16", "E32"], wp.workload_profile_type)
    ])
    error_message = "Workload profile type must be one of: Consumption, D4, D8, D16, D32, E4, E8, E16, E32."
  }
}

################################################################################
# Optional Variables - Dapr Components
################################################################################

variable "dapr_components" {
  description = "List of Dapr components to create in the environment."
  type = list(object({
    name           = string
    component_type = string
    version        = string
    ignore_errors  = optional(bool, false)
    init_timeout   = optional(string, "5s")
    scopes         = optional(list(string), [])
    metadata = optional(list(object({
      name        = string
      value       = optional(string)
      secret_name = optional(string)
    })), [])
    secret = optional(list(object({
      name  = string
      value = string
    })), [])
  }))
  default   = []
  sensitive = true
}

################################################################################
# Optional Variables - Storage
################################################################################

variable "storages" {
  description = "List of storage configurations for the environment."
  type = list(object({
    name             = string
    account_name     = string
    share_name       = string
    access_key       = string
    access_mode      = optional(string, "ReadOnly")
  }))
  default   = []
  sensitive = true

  validation {
    condition = alltrue([
      for s in var.storages :
      contains(["ReadOnly", "ReadWrite"], s.access_mode)
    ])
    error_message = "Storage access mode must be ReadOnly or ReadWrite."
  }
}

################################################################################
# Optional Variables - Certificates
################################################################################

variable "certificates" {
  description = "List of certificates to add to the environment."
  type = list(object({
    name                         = string
    certificate_blob_base64      = optional(string)
    certificate_password         = optional(string)
    key_vault_certificate_id     = optional(string)
    certificate_key_vault_id     = optional(string)
  }))
  default   = []
  sensitive = true
}

################################################################################
# Optional Variables - Tags
################################################################################

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
