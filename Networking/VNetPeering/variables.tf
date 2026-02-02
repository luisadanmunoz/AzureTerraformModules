################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the VNet Peering."
  type        = bool
  default     = true
}

################################################################################
# Required Variables - Dependencies
################################################################################

variable "resource_group_name" {
  description = <<-EOT
    (Required) The name of the Resource Group containing the source Virtual Network.
    DEPENDENCY: Resource Group must exist.
  EOT
  type        = string

  validation {
    condition     = var.resource_group_name != null && var.resource_group_name != ""
    error_message = "resource_group_name is required."
  }
}

variable "virtual_network_name" {
  description = <<-EOT
    (Required) The name of the source Virtual Network.
    DEPENDENCY: Virtual Network must exist.
  EOT
  type        = string

  validation {
    condition     = var.virtual_network_name != null && var.virtual_network_name != ""
    error_message = "virtual_network_name is required."
  }
}

variable "remote_virtual_network_id" {
  description = <<-EOT
    (Required) The full resource ID of the remote Virtual Network to peer with.
    DEPENDENCY: Remote Virtual Network must exist.
    Format: /subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.Network/virtualNetworks/{vnet}
  EOT
  type        = string

  validation {
    condition     = var.remote_virtual_network_id != null && var.remote_virtual_network_id != ""
    error_message = "remote_virtual_network_id is required."
  }
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = <<-EOT
    (Optional) The name of the VNet peering.
    If not provided, auto-generated as: peer-{source_vnet}-to-{remote_vnet}
  EOT
  type        = string
  default     = null
}

variable "remote_virtual_network_name" {
  description = "(Optional) The name of the remote VNet (used for auto-naming if 'name' not provided)."
  type        = string
  default     = null
}

################################################################################
# Peering Configuration
################################################################################

variable "allow_virtual_network_access" {
  description = <<-EOT
    (Optional) Allow VMs in the remote VNet to access VMs in the local VNet.
    Default is true.
  EOT
  type        = bool
  default     = true
}

variable "allow_forwarded_traffic" {
  description = <<-EOT
    (Optional) Allow forwarded traffic from VMs in the remote VNet.
    Required for hub-spoke topologies with NVA.
    Default is false.
  EOT
  type        = bool
  default     = false
}

variable "allow_gateway_transit" {
  description = <<-EOT
    (Optional) Allow the remote VNet to use this VNet's gateway.
    Enable on hub VNet that has the VPN/ExpressRoute Gateway.
    DEPENDENCY: VNet Gateway must exist in this VNet.
    Default is false.
  EOT
  type        = bool
  default     = false
}

variable "use_remote_gateways" {
  description = <<-EOT
    (Optional) Use the remote VNet's gateway for transit.
    Enable on spoke VNets to use hub's gateway.
    DEPENDENCY: Remote VNet must have gateway_transit enabled and a gateway deployed.
    Cannot be true if this VNet has a gateway.
    Default is false.
  EOT
  type        = bool
  default     = false
}

variable "local_subnet_names" {
  description = <<-EOT
    (Optional) Only peer specific subnets from the local VNet.
    If null, all subnets are peered.
  EOT
  type        = list(string)
  default     = null
}

variable "remote_subnet_names" {
  description = <<-EOT
    (Optional) Only peer specific subnets from the remote VNet.
    If null, all subnets are peered.
  EOT
  type        = list(string)
  default     = null
}

################################################################################
# Bidirectional Peering (Optional)
################################################################################

variable "create_reverse_peering" {
  description = <<-EOT
    (Optional) Create the reverse peering (from remote to local VNet).
    Requires appropriate permissions on the remote subscription.
    Default is false.
  EOT
  type        = bool
  default     = false
}

variable "reverse_peering_name" {
  description = "(Optional) Name for the reverse peering. Auto-generated if not provided."
  type        = string
  default     = null
}

variable "reverse_peering_resource_group_name" {
  description = <<-EOT
    (Optional) Resource Group name of the remote VNet (for reverse peering).
    Required if create_reverse_peering is true.
  EOT
  type        = string
  default     = null
}

variable "reverse_allow_virtual_network_access" {
  description = "(Optional) allow_virtual_network_access for reverse peering."
  type        = bool
  default     = true
}

variable "reverse_allow_forwarded_traffic" {
  description = "(Optional) allow_forwarded_traffic for reverse peering."
  type        = bool
  default     = false
}

variable "reverse_allow_gateway_transit" {
  description = "(Optional) allow_gateway_transit for reverse peering."
  type        = bool
  default     = false
}

variable "reverse_use_remote_gateways" {
  description = "(Optional) use_remote_gateways for reverse peering."
  type        = bool
  default     = false
}
