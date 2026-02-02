################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Public IP. Set to false to disable resource creation."
  type        = bool
  default     = true
}

################################################################################
# Required Variables - Dependencies
################################################################################

variable "resource_group_name" {
  description = <<-EOT
    (Required) The name of the Resource Group where the Public IP will be created.
    DEPENDENCY: Resource Group must exist before creating the Public IP.
  EOT
  type        = string

  validation {
    condition     = var.resource_group_name != null && var.resource_group_name != ""
    error_message = "resource_group_name is required and cannot be empty."
  }
}

variable "location" {
  description = <<-EOT
    (Required) The Azure region where the Public IP will be deployed.
    DEPENDENCY: Should match the Resource Group location.
  EOT
  type        = string

  validation {
    condition     = var.location != null && var.location != ""
    error_message = "location is required and cannot be empty."
  }
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) The explicit name for the Public IP. If provided, overrides name_prefix/name_suffix logic."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix to prepend to the generated Public IP name."
  type        = string
  default     = "pip"
}

variable "name_suffix" {
  description = "(Optional) Suffix to append to the generated Public IP name."
  type        = string
  default     = ""
}

variable "workload" {
  description = "(Optional) The workload or purpose name, used for naming convention."
  type        = string
  default     = "default"
}

variable "environment" {
  description = "(Optional) The environment name (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "instance" {
  description = "(Optional) Instance number or identifier for naming convention."
  type        = string
  default     = "001"
}

################################################################################
# Public IP Configuration
################################################################################

variable "allocation_method" {
  description = <<-EOT
    (Optional) The allocation method for the Public IP.
    Possible values: "Static" or "Dynamic".
    Note: Standard SKU requires Static allocation.
  EOT
  type        = string
  default     = "Static"

  validation {
    condition     = contains(["Static", "Dynamic"], var.allocation_method)
    error_message = "allocation_method must be either 'Static' or 'Dynamic'."
  }
}

variable "sku" {
  description = <<-EOT
    (Optional) The SKU of the Public IP.
    Possible values: "Basic" or "Standard".
    Standard is recommended for production and is required for zone redundancy.
  EOT
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard"], var.sku)
    error_message = "sku must be either 'Basic' or 'Standard'."
  }
}

variable "sku_tier" {
  description = <<-EOT
    (Optional) The SKU tier of the Public IP.
    Possible values: "Regional" or "Global".
    Global is used for cross-region load balancers.
  EOT
  type        = string
  default     = "Regional"

  validation {
    condition     = contains(["Regional", "Global"], var.sku_tier)
    error_message = "sku_tier must be either 'Regional' or 'Global'."
  }
}

variable "ip_version" {
  description = "(Optional) The IP version. Possible values: 'IPv4' or 'IPv6'."
  type        = string
  default     = "IPv4"

  validation {
    condition     = contains(["IPv4", "IPv6"], var.ip_version)
    error_message = "ip_version must be either 'IPv4' or 'IPv6'."
  }
}

variable "zones" {
  description = <<-EOT
    (Optional) List of availability zones for the Public IP.
    Use ["1", "2", "3"] for zone-redundant or ["1"] for zonal.
    Requires Standard SKU.
  EOT
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "idle_timeout_in_minutes" {
  description = "(Optional) The idle timeout in minutes (4-30). Default is 4."
  type        = number
  default     = 4

  validation {
    condition     = var.idle_timeout_in_minutes >= 4 && var.idle_timeout_in_minutes <= 30
    error_message = "idle_timeout_in_minutes must be between 4 and 30."
  }
}

variable "domain_name_label" {
  description = <<-EOT
    (Optional) The DNS label for the public IP.
    Creates FQDN: <label>.<region>.cloudapp.azure.com
  EOT
  type        = string
  default     = null
}

variable "domain_name_label_scope" {
  description = <<-EOT
    (Optional) The scope of the domain name label.
    Possible values: "NoReuse", "ResourceGroupReuse", "SubscriptionReuse", "TenantReuse".
  EOT
  type        = string
  default     = null

  validation {
    condition     = var.domain_name_label_scope == null || contains(["NoReuse", "ResourceGroupReuse", "SubscriptionReuse", "TenantReuse"], var.domain_name_label_scope)
    error_message = "domain_name_label_scope must be one of: NoReuse, ResourceGroupReuse, SubscriptionReuse, TenantReuse."
  }
}

variable "reverse_fqdn" {
  description = "(Optional) The reverse FQDN for the Public IP."
  type        = string
  default     = null
}

variable "ip_tags" {
  description = "(Optional) A map of IP tags to assign (e.g., routing preference)."
  type        = map(string)
  default     = {}
}

variable "public_ip_prefix_id" {
  description = <<-EOT
    (Optional) The ID of the Public IP Prefix to allocate from.
    DEPENDENCY: Public IP Prefix must exist before referencing.
  EOT
  type        = string
  default     = null
}

variable "edge_zone" {
  description = "(Optional) The Edge Zone where this Public IP should exist."
  type        = string
  default     = null
}

variable "ddos_protection_mode" {
  description = <<-EOT
    (Optional) The DDoS protection mode.
    Possible values: "Disabled", "Enabled", "VirtualNetworkInherited".
  EOT
  type        = string
  default     = "VirtualNetworkInherited"

  validation {
    condition     = contains(["Disabled", "Enabled", "VirtualNetworkInherited"], var.ddos_protection_mode)
    error_message = "ddos_protection_mode must be one of: Disabled, Enabled, VirtualNetworkInherited."
  }
}

variable "ddos_protection_plan_id" {
  description = <<-EOT
    (Optional) The ID of the DDoS Protection Plan.
    DEPENDENCY: DDoS Protection Plan must exist before referencing.
    Required when ddos_protection_mode is "Enabled".
  EOT
  type        = string
  default     = null
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A map of tags to assign to the Public IP."
  type        = map(string)
  default     = {}
}

################################################################################
# Diagnostic Settings (Optional)
################################################################################

variable "diagnostic_settings" {
  description = <<-EOT
    (Optional) Diagnostic settings configuration for the Public IP.
    DEPENDENCY: Log Analytics Workspace, Storage Account, or Event Hub must exist.
  EOT
  type = object({
    name                           = optional(string, "diag-pip")
    log_analytics_workspace_id     = optional(string, null)
    storage_account_id             = optional(string, null)
    eventhub_authorization_rule_id = optional(string, null)
    eventhub_name                  = optional(string, null)
    log_categories                 = optional(list(string), ["DDoSProtectionNotifications", "DDoSMitigationFlowLogs", "DDoSMitigationReports"])
    metric_categories              = optional(list(string), ["AllMetrics"])
  })
  default = null
}
