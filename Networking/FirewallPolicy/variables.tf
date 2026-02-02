################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Firewall Policy."
  type        = bool
  default     = true
}

################################################################################
# Required Variables
################################################################################

variable "resource_group_name" {
  description = <<-EOT
    (Required) The name of the Resource Group.
    DEPENDENCY: Resource Group must exist.
  EOT
  type        = string
}

variable "location" {
  description = "(Required) The Azure region."
  type        = string
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) Explicit name for the Firewall Policy."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for generated name."
  type        = string
  default     = "afwp"
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
# Policy Configuration
################################################################################

variable "sku" {
  description = "(Optional) SKU tier: Basic, Standard, or Premium."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "sku must be Basic, Standard, or Premium."
  }
}

variable "base_policy_id" {
  description = <<-EOT
    (Optional) ID of the base/parent Firewall Policy.
    DEPENDENCY: Parent policy must exist. Used for policy inheritance.
  EOT
  type        = string
  default     = null
}

variable "threat_intelligence_mode" {
  description = "(Optional) Threat Intelligence mode: Off, Alert, or Deny."
  type        = string
  default     = "Alert"

  validation {
    condition     = contains(["Off", "Alert", "Deny"], var.threat_intelligence_mode)
    error_message = "threat_intelligence_mode must be Off, Alert, or Deny."
  }
}

variable "threat_intelligence_allowlist" {
  description = "(Optional) Threat Intelligence allowlist configuration."
  type = object({
    fqdns        = optional(list(string), [])
    ip_addresses = optional(list(string), [])
  })
  default = null
}

variable "private_ip_ranges" {
  description = "(Optional) Private IP ranges for SNAT. Use IANAPrivateRanges for RFC1918."
  type        = list(string)
  default     = null
}

variable "auto_learn_private_ranges_enabled" {
  description = "(Optional) Enable auto-learning of private IP ranges."
  type        = bool
  default     = false
}

variable "sql_redirect_allowed" {
  description = "(Optional) Allow SQL redirect traffic."
  type        = bool
  default     = false
}

################################################################################
# DNS Configuration
################################################################################

variable "dns" {
  description = <<-EOT
    (Optional) DNS configuration for the policy.

    Attributes:
      - proxy_enabled: Enable DNS proxy.
      - servers: Custom DNS servers.
  EOT
  type = object({
    proxy_enabled = optional(bool, true)
    servers       = optional(list(string), null)
  })
  default = null
}

################################################################################
# Intrusion Detection (Premium Only)
################################################################################

variable "intrusion_detection" {
  description = <<-EOT
    (Optional) IDPS configuration (Premium SKU only).

    Attributes:
      - mode: Off, Alert, or Deny.
      - private_ranges: Private IP ranges for IDPS.
      - signature_overrides: List of signature overrides.
      - traffic_bypass: Traffic bypass rules.
  EOT
  type = object({
    mode           = optional(string, "Alert")
    private_ranges = optional(list(string), null)
    signature_overrides = optional(list(object({
      id    = string
      state = string # Off, Alert, Deny
    })), [])
    traffic_bypass = optional(list(object({
      name                  = string
      protocol              = string
      source_addresses      = optional(list(string), null)
      source_ip_groups      = optional(list(string), null)
      destination_addresses = optional(list(string), null)
      destination_ip_groups = optional(list(string), null)
      destination_ports     = optional(list(string), null)
      description           = optional(string, null)
    })), [])
  })
  default = null
}

################################################################################
# TLS Inspection (Premium Only)
################################################################################

variable "tls_certificate" {
  description = <<-EOT
    (Optional) TLS inspection certificate (Premium SKU only).
    DEPENDENCY: Key Vault certificate must exist.

    Attributes:
      - key_vault_secret_id: Key Vault secret ID for the certificate.
      - name: Certificate name.
  EOT
  type = object({
    key_vault_secret_id = string
    name                = string
  })
  default = null
}

variable "identity" {
  description = <<-EOT
    (Optional) Managed identity for Key Vault access (required for TLS inspection).
    DEPENDENCY: User-assigned managed identity must exist.

    Attributes:
      - type: Identity type (UserAssigned).
      - identity_ids: List of user-assigned identity IDs.
  EOT
  type = object({
    type         = optional(string, "UserAssigned")
    identity_ids = list(string)
  })
  default = null
}

################################################################################
# Explicit Proxy (Premium Only)
################################################################################

variable "explicit_proxy" {
  description = <<-EOT
    (Optional) Explicit proxy configuration (Premium SKU only).

    Attributes:
      - enabled: Enable explicit proxy.
      - http_port: HTTP port (default 8080).
      - https_port: HTTPS port (default 8443).
      - enable_pac_file: Enable PAC file.
      - pac_file_port: PAC file port.
      - pac_file: PAC file SAS URL.
  EOT
  type = object({
    enabled         = optional(bool, true)
    http_port       = optional(number, 8080)
    https_port      = optional(number, 8443)
    enable_pac_file = optional(bool, false)
    pac_file_port   = optional(number, null)
    pac_file        = optional(string, null)
  })
  default = null
}

################################################################################
# Insights / Log Analytics
################################################################################

variable "insights" {
  description = <<-EOT
    (Optional) Policy insights configuration.
    DEPENDENCY: Log Analytics workspace must exist.

    Attributes:
      - enabled: Enable insights.
      - default_log_analytics_workspace_id: Default workspace ID.
      - retention_in_days: Log retention (30-730 days).
      - log_analytics_workspaces: Per-region workspace mappings.
  EOT
  type = object({
    enabled                            = optional(bool, true)
    default_log_analytics_workspace_id = string
    retention_in_days                  = optional(number, 30)
    log_analytics_workspaces = optional(list(object({
      id                = string
      firewall_location = string
    })), [])
  })
  default = null
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) Tags to assign to resources."
  type        = map(string)
  default     = {}
}
