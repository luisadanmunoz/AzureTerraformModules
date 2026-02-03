################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Network Watcher."
  type        = bool
  default     = true
}

################################################################################
# Required Variables
################################################################################

variable "resource_group_name" {
  description = "(Required) Resource Group name. DEPENDENCY: Must exist."
  type        = string
}

variable "location" {
  description = "(Required) Azure region."
  type        = string
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) Explicit name for the Network Watcher."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for generated name."
  type        = string
  default     = "nw"
}

variable "workload" {
  description = "(Optional) Workload name."
  type        = string
  default     = "shared"
}

variable "environment" {
  description = "(Optional) Environment name."
  type        = string
  default     = "prod"
}

variable "instance" {
  description = "(Optional) Instance identifier."
  type        = string
  default     = "001"
}

################################################################################
# Flow Logs
################################################################################

variable "flow_logs" {
  description = "(Optional) List of NSG Flow Log configurations."
  type = list(object({
    name                      = string
    network_security_group_id = string
    storage_account_id        = string
    enabled                   = optional(bool, true)
    retention_policy_enabled  = optional(bool, true)
    retention_policy_days     = optional(number, 90)
    version                   = optional(number, 2)

    traffic_analytics_enabled                 = optional(bool, false)
    traffic_analytics_workspace_id            = optional(string, null)
    traffic_analytics_workspace_region        = optional(string, null)
    traffic_analytics_workspace_resource_id   = optional(string, null)
    traffic_analytics_interval_in_minutes     = optional(number, 60)
  }))
  default = []
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) Tags to assign to resources."
  type        = map(string)
  default     = {}
}
