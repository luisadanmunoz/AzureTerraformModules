################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Virtual WAN and associated resources."
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
  description = "(Optional) Explicit name for the Virtual WAN."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for generated name."
  type        = string
  default     = "vwan"
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
# Virtual WAN Configuration
################################################################################

variable "disable_vpn_encryption" {
  description = "(Optional) Disable VPN encryption for the Virtual WAN."
  type        = bool
  default     = false
}

variable "allow_branch_to_branch_traffic" {
  description = "(Optional) Allow branch-to-branch traffic flow."
  type        = bool
  default     = true
}

variable "office365_local_breakout_category" {
  description = "(Optional) Office 365 local breakout category. Valid values: None, Optimize, OptimizeAndAllow, All."
  type        = string
  default     = "None"

  validation {
    condition     = contains(["None", "Optimize", "OptimizeAndAllow", "All"], var.office365_local_breakout_category)
    error_message = "office365_local_breakout_category must be one of: None, Optimize, OptimizeAndAllow, All."
  }
}

variable "type" {
  description = "(Optional) Virtual WAN type. Valid values: Basic, Standard."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard"], var.type)
    error_message = "type must be Basic or Standard."
  }
}

################################################################################
# Virtual Hubs
################################################################################

variable "virtual_hubs" {
  description = <<-EOT
    (Optional) List of Virtual Hubs to create within the Virtual WAN.

    Attributes:
      - name:                                     (Required) Name of the Virtual Hub.
      - location:                                 (Required) Azure region for the Virtual Hub.
      - address_prefix:                           (Required) Address prefix for the Virtual Hub (e.g., "10.0.0.0/23").
      - sku:                                      (Optional) SKU of the Virtual Hub. Defaults to "Standard".
      - hub_routing_preference:                   (Optional) Routing preference. Valid values: ExpressRoute, ASPath, VpnGateway.
      - virtual_router_auto_scale_min_capacity:   (Optional) Minimum number of scale units for Virtual Router auto scale.
  EOT
  type = list(object({
    name                                   = string
    location                               = string
    address_prefix                         = string
    sku                                    = optional(string, "Standard")
    hub_routing_preference                 = optional(string, null)
    virtual_router_auto_scale_min_capacity = optional(number, null)
  }))
  default = []
}

################################################################################
# VPN Gateways
################################################################################

variable "vpn_gateways" {
  description = <<-EOT
    (Optional) List of VPN Gateways to create within Virtual Hubs.

    Attributes:
      - name:                                    (Required) Name of the VPN Gateway.
      - virtual_hub_key:                         (Required) Index key of the Virtual Hub from the virtual_hubs list.
      - bgp_route_translation_for_nat_enabled:   (Optional) Enable BGP route translation for NAT.
      - bgp_settings:                            (Optional) BGP settings configuration.
      - routing_preference:                      (Optional) Azure routing preference. Valid values: Microsoft Network, Internet.
      - scale_unit:                              (Optional) Scale unit for the VPN Gateway. Defaults to 1.
  EOT
  type = list(object({
    name                                  = string
    virtual_hub_key                       = number
    bgp_route_translation_for_nat_enabled = optional(bool, false)
    bgp_settings = optional(object({
      asn         = number
      peer_weight = number
      instance_0_bgp_peering_address = optional(object({
        custom_ips = list(string)
      }), null)
      instance_1_bgp_peering_address = optional(object({
        custom_ips = list(string)
      }), null)
    }), null)
    routing_preference = optional(string, null)
    scale_unit         = optional(number, 1)
  }))
  default = []
}

################################################################################
# VPN Sites
################################################################################

variable "vpn_sites" {
  description = <<-EOT
    (Optional) List of VPN Sites to create for the Virtual WAN.

    Attributes:
      - name:            (Required) Name of the VPN Site.
      - address_cidrs:   (Optional) List of address CIDRs for the VPN Site.
      - device_model:    (Optional) Model of the VPN device.
      - device_vendor:   (Optional) Vendor of the VPN device.
      - links:           (Optional) List of VPN Site Links.
  EOT
  type = list(object({
    name          = string
    address_cidrs = optional(list(string), null)
    device_model  = optional(string, null)
    device_vendor = optional(string, null)
    links = optional(list(object({
      name          = string
      ip_address    = optional(string, null)
      fqdn          = optional(string, null)
      provider_name = optional(string, null)
      speed_in_mbps = optional(number, 0)
      bgp = optional(object({
        asn             = number
        peering_address = string
      }), null)
    })), [])
  }))
  default = []
}

################################################################################
# ExpressRoute Gateways
################################################################################

variable "er_gateways" {
  description = <<-EOT
    (Optional) List of ExpressRoute Gateways to create within Virtual Hubs.

    Attributes:
      - name:                          (Required) Name of the ExpressRoute Gateway.
      - virtual_hub_key:               (Required) Index key of the Virtual Hub from the virtual_hubs list.
      - scale_unit:                    (Required) Scale unit for the ExpressRoute Gateway.
      - allow_non_virtual_wan_traffic: (Optional) Allow non-Virtual-WAN traffic. Defaults to false.
  EOT
  type = list(object({
    name                          = string
    virtual_hub_key               = number
    scale_unit                    = number
    allow_non_virtual_wan_traffic = optional(bool, false)
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
