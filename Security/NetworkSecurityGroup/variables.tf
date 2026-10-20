################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Network Security Group. Set to false to disable resource creation without removing module code."
  type        = bool
  default     = true
}

################################################################################
# Required Variables - Dependencies
################################################################################

variable "resource_group_name" {
  description = <<-EOT
    (Required) The name of the Resource Group where the NSG will be created.
    DEPENDENCY: Resource Group must exist before creating the NSG.
  EOT
  type        = string

  validation {
    condition     = var.resource_group_name != null && var.resource_group_name != ""
    error_message = "resource_group_name is required and cannot be empty."
  }
}

variable "location" {
  description = <<-EOT
    (Required) The Azure region where the NSG will be deployed.
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
  description = "(Optional) The explicit name for the NSG. If provided, overrides name_prefix/name_suffix logic."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix to prepend to the generated NSG name. Used when 'name' is not provided."
  type        = string
  default     = "nsg"
}

variable "name_suffix" {
  description = "(Optional) Suffix to append to the generated NSG name. Used when 'name' is not provided."
  type        = string
  default     = ""
}

variable "workload" {
  description = "(Optional) The workload or purpose name, used for naming convention."
  type        = string
  default     = "default"
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
# Security Rules
################################################################################

variable "security_rules" {
  description = <<-EOT
    (Optional) Map of security rules to create in the NSG.

    Attributes:
      - priority: Rule priority (100-4096). Lower numbers are evaluated first.
      - direction: "Inbound" or "Outbound".
      - access: "Allow" or "Deny".
      - protocol: "Tcp", "Udp", "Icmp", "Esp", "Ah", or "*".
      - source_port_range: Source port or range (e.g., "80", "80-443", "*").
      - source_port_ranges: List of source ports (alternative to source_port_range).
      - destination_port_range: Destination port or range.
      - destination_port_ranges: List of destination ports.
      - source_address_prefix: Source CIDR, service tag, or "*".
      - source_address_prefixes: List of source CIDRs.
      - source_application_security_group_ids: List of source ASG IDs.
      - destination_address_prefix: Destination CIDR, service tag, or "*".
      - destination_address_prefixes: List of destination CIDRs.
      - destination_application_security_group_ids: List of destination ASG IDs.
      - description: Optional rule description.
  EOT
  type = map(object({
    priority                                   = number
    direction                                  = string
    access                                     = string
    protocol                                   = string
    source_port_range                          = optional(string, null)
    source_port_ranges                         = optional(list(string), null)
    destination_port_range                     = optional(string, null)
    destination_port_ranges                    = optional(list(string), null)
    source_address_prefix                      = optional(string, null)
    source_address_prefixes                    = optional(list(string), null)
    source_application_security_group_ids      = optional(list(string), null)
    destination_address_prefix                 = optional(string, null)
    destination_address_prefixes               = optional(list(string), null)
    destination_application_security_group_ids = optional(list(string), null)
    description                                = optional(string, null)
  }))
  default = {}

  validation {
    condition = alltrue([
      for k, v in var.security_rules : contains(["Inbound", "Outbound"], v.direction)
    ])
    error_message = "security_rules direction must be either 'Inbound' or 'Outbound'."
  }

  validation {
    condition = alltrue([
      for k, v in var.security_rules : contains(["Allow", "Deny"], v.access)
    ])
    error_message = "security_rules access must be either 'Allow' or 'Deny'."
  }

  validation {
    condition = alltrue([
      for k, v in var.security_rules : v.priority >= 100 && v.priority <= 4096
    ])
    error_message = "security_rules priority must be between 100 and 4096."
  }
}

################################################################################
# Common Rule Presets (Optional)
################################################################################

variable "allow_ssh" {
  description = "(Optional) Enable a preset rule to allow SSH (port 22) from specified sources."
  type = object({
    enabled                = bool
    priority               = optional(number, 100)
    source_address_prefix  = optional(string, "*")
    source_address_prefixes = optional(list(string), null)
  })
  default = {
    enabled = false
  }
}

variable "allow_rdp" {
  description = "(Optional) Enable a preset rule to allow RDP (port 3389) from specified sources."
  type = object({
    enabled                = bool
    priority               = optional(number, 110)
    source_address_prefix  = optional(string, "*")
    source_address_prefixes = optional(list(string), null)
  })
  default = {
    enabled = false
  }
}

variable "allow_https" {
  description = "(Optional) Enable a preset rule to allow HTTPS (port 443) from specified sources."
  type = object({
    enabled                = bool
    priority               = optional(number, 120)
    source_address_prefix  = optional(string, "*")
    source_address_prefixes = optional(list(string), null)
  })
  default = {
    enabled = false
  }
}

variable "allow_http" {
  description = "(Optional) Enable a preset rule to allow HTTP (port 80) from specified sources."
  type = object({
    enabled                = bool
    priority               = optional(number, 130)
    source_address_prefix  = optional(string, "*")
    source_address_prefixes = optional(list(string), null)
  })
  default = {
    enabled = false
  }
}

variable "deny_all_inbound" {
  description = "(Optional) Enable a preset rule to deny all inbound traffic (lowest priority)."
  type = object({
    enabled  = bool
    priority = optional(number, 4096)
  })
  default = {
    enabled = false
  }
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A map of tags to assign to the NSG."
  type        = map(string)
  default     = {}
}

################################################################################
# Diagnostic Settings (Optional)
################################################################################

variable "diagnostic_settings" {
  description = <<-EOT
    (Optional) Diagnostic settings configuration for the NSG.
    DEPENDENCY: Log Analytics Workspace, Storage Account, or Event Hub must exist.

    Attributes:
      - name: Name of the diagnostic setting.
      - log_analytics_workspace_id: Resource ID of the Log Analytics Workspace.
      - storage_account_id: Resource ID of the Storage Account for archival.
      - eventhub_authorization_rule_id: Authorization rule ID for Event Hub.
      - eventhub_name: Name of the Event Hub.
      - log_categories: List of log categories to enable.
  EOT
  type = object({
    name                           = optional(string, "diag-nsg")
    log_analytics_workspace_id     = optional(string, null)
    storage_account_id             = optional(string, null)
    eventhub_authorization_rule_id = optional(string, null)
    eventhub_name                  = optional(string, null)
    log_categories                 = optional(list(string), ["NetworkSecurityGroupEvent", "NetworkSecurityGroupRuleCounter"])
  })
  default = null
}
