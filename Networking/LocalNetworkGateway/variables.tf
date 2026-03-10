variable "create" {
  description = "Controls whether to create the Local Network Gateway."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) Resource Group name. DEPENDENCY: Must exist."
  type        = string
}

variable "location" {
  description = "(Required) Azure region."
  type        = string
}

variable "name" {
  description = "(Optional) Explicit name for the Local Network Gateway."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for generated name."
  type        = string
  default     = "lgw"
}

variable "workload" {
  description = "(Optional) Workload name."
  type        = string
  default     = "onprem"
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

variable "gateway_address" {
  description = "(Optional) The public IP of the on-premises VPN device. Required if gateway_fqdn not set."
  type        = string
  default     = null
}

variable "gateway_fqdn" {
  description = "(Optional) The FQDN of the on-premises VPN device. Required if gateway_address not set."
  type        = string
  default     = null
}

variable "address_space" {
  description = "(Optional) List of on-premises network CIDR ranges."
  type        = list(string)
  default     = []
}

variable "bgp_settings" {
  description = <<-EOT
    (Optional) BGP settings for the on-premises device.

    Attributes:
      - asn: BGP ASN.
      - bgp_peering_address: BGP peering IP.
      - peer_weight: Peer weight.
  EOT
  type = object({
    asn                 = number
    bgp_peering_address = string
    peer_weight         = optional(number, 0)
  })
  default = null
}

variable "tags" {
  description = "(Optional) Tags to assign to resources."
  type        = map(string)
  default     = {}
}
