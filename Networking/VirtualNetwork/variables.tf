################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Virtual Network. Set to false to disable resource creation without removing module code."
  type        = bool
  default     = true
}

################################################################################
# Required Variables - Dependencies
################################################################################

variable "resource_group_name" {
  description = <<-EOT
    (Required) The name of the Resource Group where the Virtual Network will be created.
    DEPENDENCY: Resource Group must exist before creating the VNet.
  EOT
  type        = string

  validation {
    condition     = var.resource_group_name != null && var.resource_group_name != ""
    error_message = "resource_group_name is required and cannot be empty."
  }
}

variable "location" {
  description = <<-EOT
    (Required) The Azure region where the Virtual Network will be deployed.
    DEPENDENCY: Should match the Resource Group location for optimal performance.
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
  description = "(Optional) The explicit name for the Virtual Network. If provided, overrides name_prefix/name_suffix logic."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix to prepend to the generated Virtual Network name. Used when 'name' is not provided."
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "(Optional) Suffix to append to the generated Virtual Network name. Used when 'name' is not provided."
  type        = string
  default     = ""
}

variable "workload" {
  description = "(Optional) The workload or application name, used for naming convention."
  type        = string
  default     = "shared"
}

variable "environment" {
  description = "(Optional) The environment name (e.g., dev, staging, prod), used for naming convention."
  type        = string
  default     = "dev"
}

variable "instance" {
  description = "(Optional) Instance number or identifier for naming convention."
  type        = string
  default     = "001"
}

################################################################################
# Network Configuration
################################################################################

variable "address_space" {
  description = <<-EOT
    (Required) The list of address spaces (CIDR blocks) for the Virtual Network.
    Example: ["10.0.0.0/16"] or ["10.0.0.0/16", "172.16.0.0/16"]
  EOT
  type        = list(string)

  validation {
    condition     = length(var.address_space) > 0
    error_message = "At least one address space must be provided."
  }
}

variable "dns_servers" {
  description = "(Optional) List of custom DNS server IP addresses. If not set, Azure-provided DNS will be used."
  type        = list(string)
  default     = []
}

variable "bgp_community" {
  description = "(Optional) The BGP Community for the Virtual Network. Format: <AS_number>:<community_value>"
  type        = string
  default     = null
}

variable "edge_zone" {
  description = "(Optional) The Edge Zone within the Azure Region where this Virtual Network should exist."
  type        = string
  default     = null
}

variable "flow_timeout_in_minutes" {
  description = "(Optional) The flow timeout in minutes for the Virtual Network (4-30 minutes). Requires Standard SKU Load Balancer."
  type        = number
  default     = null

  validation {
    condition     = var.flow_timeout_in_minutes == null || (var.flow_timeout_in_minutes >= 4 && var.flow_timeout_in_minutes <= 30)
    error_message = "flow_timeout_in_minutes must be between 4 and 30 minutes."
  }
}

################################################################################
# DDoS Protection
################################################################################

variable "ddos_protection_plan" {
  description = <<-EOT
    (Optional) DDoS Protection Plan configuration.
    DEPENDENCY: DDoS Protection Plan must exist before referencing its ID.

    Attributes:
      - id: The ID of the DDoS Protection Plan to associate.
      - enable: Whether to enable DDoS protection on this VNet.
  EOT
  type = object({
    id     = string
    enable = bool
  })
  default = null
}

################################################################################
# Encryption
################################################################################

variable "encryption" {
  description = <<-EOT
    (Optional) Virtual Network encryption configuration (preview feature).

    Attributes:
      - enforcement: Specifies if encryption is enforced. Possible values: "AllowUnencrypted", "DropUnencrypted".
  EOT
  type = object({
    enforcement = string
  })
  default = null

  validation {
    condition     = var.encryption == null || contains(["AllowUnencrypted", "DropUnencrypted"], var.encryption.enforcement)
    error_message = "encryption.enforcement must be either 'AllowUnencrypted' or 'DropUnencrypted'."
  }
}

################################################################################
# Inline Subnets (Optional)
################################################################################

variable "subnets" {
  description = <<-EOT
    (Optional) Map of inline subnets to create within the Virtual Network.
    Note: For complex subnet configurations, consider using the dedicated Subnet module.

    Attributes:
      - address_prefixes: List of address prefixes for the subnet.
      - private_endpoint_network_policies: Enable/disable network policies for private endpoints.
      - private_link_service_network_policies_enabled: Enable/disable network policies for private link services.
      - service_endpoints: List of service endpoints to associate.
      - delegation: Optional service delegation configuration.
  EOT
  type = map(object({
    address_prefixes                              = list(string)
    private_endpoint_network_policies             = optional(string, "Disabled")
    private_link_service_network_policies_enabled = optional(bool, false)
    service_endpoints                             = optional(list(string), [])
    delegation = optional(object({
      name = string
      service_delegation = object({
        name    = string
        actions = optional(list(string), [])
      })
    }), null)
  }))
  default = {}
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A map of tags to assign to the Virtual Network."
  type        = map(string)
  default     = {}
}

################################################################################
# Diagnostic Settings (Optional)
################################################################################

variable "diagnostic_settings" {
  description = <<-EOT
    (Optional) Diagnostic settings configuration for the Virtual Network.
    DEPENDENCY: Log Analytics Workspace, Storage Account, or Event Hub must exist before referencing.

    Attributes:
      - name: Name of the diagnostic setting.
      - log_analytics_workspace_id: Resource ID of the Log Analytics Workspace.
      - storage_account_id: Resource ID of the Storage Account for archival.
      - eventhub_authorization_rule_id: Authorization rule ID for Event Hub.
      - eventhub_name: Name of the Event Hub.
      - log_categories: List of log categories to enable.
      - metric_categories: List of metric categories to enable.
  EOT
  type = object({
    name                           = optional(string, "diag-vnet")
    log_analytics_workspace_id     = optional(string, null)
    storage_account_id             = optional(string, null)
    eventhub_authorization_rule_id = optional(string, null)
    eventhub_name                  = optional(string, null)
    log_categories                 = optional(list(string), ["VMProtectionAlerts"])
    metric_categories              = optional(list(string), ["AllMetrics"])
  })
  default = null
}
