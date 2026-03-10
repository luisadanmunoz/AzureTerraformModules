################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Bastion Host."
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

variable "subnet_id" {
  description = <<-EOT
    (Required) The ID of the AzureBastionSubnet.
    DEPENDENCY: Subnet named "AzureBastionSubnet" must exist with minimum /26 prefix.
  EOT
  type        = string
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) Explicit name for the Bastion Host."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for generated name."
  type        = string
  default     = "bas"
}

variable "workload" {
  description = "(Optional) Workload name."
  type        = string
  default     = "hub"
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
# Bastion Configuration
################################################################################

variable "sku" {
  description = <<-EOT
    (Optional) Bastion SKU: Basic, Standard, or Premium.
    - Basic: RDP/SSH only
    - Standard: Adds native client, IP-based connection, shareable link
    - Premium: Adds session recording
  EOT
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "sku must be Basic, Standard, or Premium."
  }
}

variable "copy_paste_enabled" {
  description = "(Optional) Enable copy/paste functionality."
  type        = bool
  default     = true
}

variable "file_copy_enabled" {
  description = "(Optional) Enable file copy feature (Standard/Premium SKU only)."
  type        = bool
  default     = false
}

variable "ip_connect_enabled" {
  description = "(Optional) Enable IP-based connection (Standard/Premium SKU only)."
  type        = bool
  default     = false
}

variable "shareable_link_enabled" {
  description = "(Optional) Enable shareable links (Standard/Premium SKU only)."
  type        = bool
  default     = false
}

variable "tunneling_enabled" {
  description = "(Optional) Enable native client tunneling (Standard/Premium SKU only)."
  type        = bool
  default     = false
}

variable "kerberos_enabled" {
  description = "(Optional) Enable Kerberos authentication (Standard/Premium SKU only)."
  type        = bool
  default     = false
}

variable "scale_units" {
  description = "(Optional) Number of scale units (2-50). Each unit supports 20 concurrent connections."
  type        = number
  default     = 2

  validation {
    condition     = var.scale_units >= 2 && var.scale_units <= 50
    error_message = "scale_units must be between 2 and 50."
  }
}

variable "virtual_network_id" {
  description = <<-EOT
    (Optional) VNet ID for session recording (Premium SKU only).
    DEPENDENCY: VNet must exist.
  EOT
  type        = string
  default     = null
}

variable "session_recording_enabled" {
  description = "(Optional) Enable session recording (Premium SKU only)."
  type        = bool
  default     = false
}

################################################################################
# Public IP Configuration
################################################################################

variable "public_ip_id" {
  description = <<-EOT
    (Optional) Existing Public IP ID. If not provided, a new one will be created.
    DEPENDENCY: Must be Standard SKU, Static allocation.
  EOT
  type        = string
  default     = null
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) Tags to assign to resources."
  type        = map(string)
  default     = {}
}

################################################################################
# Diagnostic Settings
################################################################################

variable "diagnostic_settings" {
  description = "(Optional) Diagnostic settings configuration."
  type = object({
    name                       = optional(string, "diag-bastion")
    log_analytics_workspace_id = optional(string, null)
    storage_account_id         = optional(string, null)
    log_categories             = optional(list(string), ["BastionAuditLogs"])
    metric_categories          = optional(list(string), ["AllMetrics"])
  })
  default = null
}
