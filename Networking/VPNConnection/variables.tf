################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the VPN Connection."
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

variable "virtual_network_gateway_id" {
  description = <<-EOT
    (Required) The ID of the Virtual Network Gateway.
    DEPENDENCY: Virtual Network Gateway must exist.
  EOT
  type        = string
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) Explicit name for the VPN Connection."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for generated name."
  type        = string
  default     = "vcn"
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
# Connection Configuration
################################################################################

variable "type" {
  description = "(Required) The type of connection: IPsec, Vnet2Vnet, or ExpressRoute."
  type        = string

  validation {
    condition     = contains(["IPsec", "Vnet2Vnet", "ExpressRoute"], var.type)
    error_message = "type must be IPsec, Vnet2Vnet, or ExpressRoute."
  }
}

variable "peer_virtual_network_gateway_id" {
  description = <<-EOT
    (Optional) The ID of the peer Virtual Network Gateway for Vnet2Vnet connections.
    Required when type is Vnet2Vnet.
  EOT
  type        = string
  default     = null
}

variable "local_network_gateway_id" {
  description = <<-EOT
    (Optional) The ID of the Local Network Gateway for IPsec connections.
    DEPENDENCY: Local Network Gateway must exist.
    Required when type is IPsec.
  EOT
  type        = string
  default     = null
}

variable "express_route_circuit_id" {
  description = <<-EOT
    (Optional) The ID of the ExpressRoute Circuit for ExpressRoute connections.
    DEPENDENCY: ExpressRoute Circuit must exist.
    Required when type is ExpressRoute.
  EOT
  type        = string
  default     = null
}

variable "shared_key" {
  description = "(Optional) The shared IPSec key. Required for IPsec and Vnet2Vnet connections."
  type        = string
  default     = null
  sensitive   = true
}

variable "connection_protocol" {
  description = "(Optional) The IKE protocol version: IKEv1 or IKEv2."
  type        = string
  default     = null

  validation {
    condition     = var.connection_protocol == null || contains(["IKEv1", "IKEv2"], var.connection_protocol)
    error_message = "connection_protocol must be IKEv1 or IKEv2."
  }
}

variable "enable_bgp" {
  description = "(Optional) Enable BGP for the connection."
  type        = bool
  default     = false
}

variable "dpd_timeout_seconds" {
  description = "(Optional) Dead Peer Detection timeout in seconds."
  type        = number
  default     = null
}

variable "use_policy_based_traffic_selectors" {
  description = "(Optional) Enable policy-based traffic selectors."
  type        = bool
  default     = false
}

################################################################################
# IPsec Policy
################################################################################

variable "ipsec_policy" {
  description = <<-EOT
    (Optional) IPsec policy configuration for the connection.

    Attributes:
      - dh_group:           DH Group: DHGroup1, DHGroup2, DHGroup14, DHGroup24, DHGroup2048, ECP256, ECP384, None.
      - ike_encryption:     IKE encryption: AES128, AES192, AES256, DES, DES3, GCMAES128, GCMAES256.
      - ike_integrity:      IKE integrity: GCMAES128, GCMAES256, MD5, SHA1, SHA256, SHA384.
      - ipsec_encryption:   IPsec encryption: AES128, AES192, AES256, DES, DES3, GCMAES128, GCMAES192, GCMAES256, None.
      - ipsec_integrity:    IPsec integrity: GCMAES128, GCMAES192, GCMAES256, MD5, SHA1, SHA256.
      - pfs_group:          PFS Group: ECP256, ECP384, None, PFS1, PFS2, PFS14, PFS24, PFS2048, PFSMM.
      - sa_lifetime:        SA lifetime in seconds.
      - sa_datasize:        SA data size in KB.
  EOT
  type = object({
    dh_group         = string
    ike_encryption   = string
    ike_integrity    = string
    ipsec_encryption = string
    ipsec_integrity  = string
    pfs_group        = string
    sa_lifetime      = optional(number, 27000)
    sa_datasize      = optional(number, 102400000)
  })
  default = null
}

################################################################################
# Traffic Selector Policy
################################################################################

variable "traffic_selector_policy" {
  description = <<-EOT
    (Optional) List of traffic selector policies for the connection.

    Attributes:
      - local_address_cidrs:  List of local address CIDRs.
      - remote_address_cidrs: List of remote address CIDRs.
  EOT
  type = list(object({
    local_address_cidrs  = list(string)
    remote_address_cidrs = list(string)
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
