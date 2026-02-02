################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the VPN Gateway."
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
    (Required) The ID of the GatewaySubnet.
    DEPENDENCY: Subnet named "GatewaySubnet" must exist with minimum /27 prefix.
  EOT
  type        = string
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) Explicit name for the VPN Gateway."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for generated name."
  type        = string
  default     = "vpngw"
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
# Gateway Configuration
################################################################################

variable "type" {
  description = "(Optional) Gateway type: Vpn or ExpressRoute."
  type        = string
  default     = "Vpn"

  validation {
    condition     = contains(["Vpn", "ExpressRoute"], var.type)
    error_message = "type must be Vpn or ExpressRoute."
  }
}

variable "vpn_type" {
  description = "(Optional) VPN type: RouteBased or PolicyBased."
  type        = string
  default     = "RouteBased"

  validation {
    condition     = contains(["RouteBased", "PolicyBased"], var.vpn_type)
    error_message = "vpn_type must be RouteBased or PolicyBased."
  }
}

variable "sku" {
  description = <<-EOT
    (Optional) Gateway SKU.
    VPN: Basic, VpnGw1, VpnGw2, VpnGw3, VpnGw4, VpnGw5, VpnGw1AZ, VpnGw2AZ, VpnGw3AZ, VpnGw4AZ, VpnGw5AZ
    ExpressRoute: Standard, HighPerformance, UltraPerformance, ErGw1AZ, ErGw2AZ, ErGw3AZ
  EOT
  type        = string
  default     = "VpnGw1AZ"
}

variable "generation" {
  description = "(Optional) VPN Gateway generation: Generation1 or Generation2."
  type        = string
  default     = "Generation2"

  validation {
    condition     = contains(["Generation1", "Generation2"], var.generation)
    error_message = "generation must be Generation1 or Generation2."
  }
}

variable "active_active" {
  description = "(Optional) Enable active-active mode. Requires two IP configurations."
  type        = bool
  default     = false
}

variable "enable_bgp" {
  description = "(Optional) Enable BGP for the gateway."
  type        = bool
  default     = false
}

variable "bgp_settings" {
  description = <<-EOT
    (Optional) BGP settings configuration.

    Attributes:
      - asn: Autonomous System Number.
      - peering_addresses: List of peering address configurations.
  EOT
  type = object({
    asn = optional(number, 65515)
    peering_addresses = optional(list(object({
      ip_configuration_name = string
      apipa_addresses       = optional(list(string), null)
    })), [])
  })
  default = null
}

variable "private_ip_address_enabled" {
  description = "(Optional) Enable private IP address on the gateway."
  type        = bool
  default     = false
}

variable "dns_forwarding_enabled" {
  description = "(Optional) Enable DNS forwarding."
  type        = bool
  default     = false
}

################################################################################
# IP Configuration
################################################################################

variable "public_ip_id" {
  description = <<-EOT
    (Optional) Existing Public IP ID. If not provided, a new one will be created.
    DEPENDENCY: Must be Standard SKU for AZ SKUs, Basic for non-AZ.
  EOT
  type        = string
  default     = null
}

variable "public_ip_id_secondary" {
  description = "(Optional) Secondary Public IP ID for active-active mode."
  type        = string
  default     = null
}

################################################################################
# VPN Client Configuration (Point-to-Site)
################################################################################

variable "vpn_client_configuration" {
  description = <<-EOT
    (Optional) Point-to-Site VPN client configuration.

    Attributes:
      - address_space: Client address pool CIDR.
      - vpn_client_protocols: IkeV2, SSTP, OpenVPN.
      - vpn_auth_types: AAD, Certificate, Radius.
      - root_certificates: List of root certificates.
      - revoked_certificates: List of revoked certificates.
      - aad_tenant: Azure AD tenant URL.
      - aad_audience: Azure AD audience.
      - aad_issuer: Azure AD issuer.
      - radius_server_address: RADIUS server IP.
      - radius_server_secret: RADIUS shared secret.
  EOT
  type = object({
    address_space        = list(string)
    vpn_client_protocols = optional(list(string), ["IkeV2", "OpenVPN"])
    vpn_auth_types       = optional(list(string), ["Certificate"])
    root_certificates = optional(list(object({
      name             = string
      public_cert_data = string
    })), [])
    revoked_certificates = optional(list(object({
      name       = string
      thumbprint = string
    })), [])
    aad_tenant              = optional(string, null)
    aad_audience            = optional(string, null)
    aad_issuer              = optional(string, null)
    radius_server_address   = optional(string, null)
    radius_server_secret    = optional(string, null)
  })
  default = null
}

################################################################################
# Custom Routes
################################################################################

variable "custom_route" {
  description = <<-EOT
    (Optional) Custom routes for the gateway.

    Attributes:
      - address_prefixes: List of address prefixes.
  EOT
  type = object({
    address_prefixes = list(string)
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

################################################################################
# Diagnostic Settings
################################################################################

variable "diagnostic_settings" {
  description = "(Optional) Diagnostic settings configuration."
  type = object({
    name                       = optional(string, "diag-vpngw")
    log_analytics_workspace_id = optional(string, null)
    storage_account_id         = optional(string, null)
    log_categories = optional(list(string), [
      "GatewayDiagnosticLog",
      "TunnelDiagnosticLog",
      "RouteDiagnosticLog",
      "IKEDiagnosticLog",
      "P2SDiagnosticLog"
    ])
    metric_categories = optional(list(string), ["AllMetrics"])
  })
  default = null
}
