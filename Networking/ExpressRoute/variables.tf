################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the ExpressRoute Circuit."
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

variable "service_provider_name" {
  description = "(Required) The name of the ExpressRoute service provider (e.g. Equinix, AT&T, Verizon)."
  type        = string
}

variable "peering_location" {
  description = "(Required) The peering location for the ExpressRoute circuit (e.g. Silicon Valley, Washington DC)."
  type        = string
}

variable "bandwidth_in_mbps" {
  description = "(Required) The bandwidth in Mbps for the ExpressRoute circuit (e.g. 50, 100, 200, 500, 1000)."
  type        = number
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) Explicit name for the ExpressRoute Circuit."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for generated name."
  type        = string
  default     = "erc"
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
# SKU Configuration
################################################################################

variable "sku_tier" {
  description = "(Optional) The service tier for the ExpressRoute circuit: Standard or Premium."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.sku_tier)
    error_message = "sku_tier must be Standard or Premium."
  }
}

variable "sku_family" {
  description = "(Optional) The billing model for the ExpressRoute circuit: MeteredData or UnlimitedData."
  type        = string
  default     = "MeteredData"

  validation {
    condition     = contains(["MeteredData", "UnlimitedData"], var.sku_family)
    error_message = "sku_family must be MeteredData or UnlimitedData."
  }
}

################################################################################
# Circuit Configuration
################################################################################

variable "allow_classic_operations" {
  description = "(Optional) Allow classic operations for the ExpressRoute circuit."
  type        = bool
  default     = false
}

variable "express_route_port_id" {
  description = "(Optional) The ID of the ExpressRoute Port resource when using ExpressRoute Direct."
  type        = string
  default     = null
}

variable "bandwidth_in_gbps" {
  description = "(Optional) The bandwidth in Gbps when using ExpressRoute Direct."
  type        = number
  default     = null
}

variable "authorization_key" {
  description = "(Optional) The authorization key for the ExpressRoute circuit."
  type        = string
  default     = null
  sensitive   = true
}

################################################################################
# Peering Configuration
################################################################################

variable "peerings" {
  description = <<-EOT
    (Optional) List of peering configurations for the ExpressRoute circuit.

    Attributes:
      - peering_type: AzurePrivatePeering, AzurePublicPeering, or MicrosoftPeering.
      - vlan_id: VLAN ID for the peering.
      - primary_peer_address_prefix: /30 subnet for the primary link.
      - secondary_peer_address_prefix: /30 subnet for the secondary link.
      - peer_asn: Peer BGP ASN.
      - shared_key: (Optional) Pre-shared key for the peering.
      - microsoft_peering_config: (Optional) Microsoft peering configuration.
  EOT
  type = list(object({
    peering_type                  = string
    vlan_id                       = number
    primary_peer_address_prefix   = string
    secondary_peer_address_prefix = string
    peer_asn                      = optional(number, null)
    shared_key                    = optional(string, null)
    microsoft_peering_config = optional(object({
      advertised_public_prefixes = list(string)
      customer_asn               = optional(number, 0)
      routing_registry_name      = optional(string, "NONE")
      advertised_communities     = optional(list(string), null)
    }), null)
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

################################################################################
# Diagnostic Settings
################################################################################

variable "diagnostic_settings" {
  description = "(Optional) Diagnostic settings configuration."
  type = object({
    name                           = optional(string, "diag-expressroute")
    log_analytics_workspace_id     = optional(string, null)
    storage_account_id             = optional(string, null)
    eventhub_authorization_rule_id = optional(string, null)
    eventhub_name                  = optional(string, null)
    log_categories = optional(list(string), [
      "PeeringRouteLog"
    ])
    metric_categories = optional(list(string), ["AllMetrics"])
  })
  default = null
}
