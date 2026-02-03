################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Route Server."
  type        = bool
  default     = true
}

################################################################################
# Required Variables - Dependencies
################################################################################

variable "resource_group_name" {
  description = <<-EOT
    (Required) The name of the Resource Group where the Route Server will be created.
    DEPENDENCY: Resource Group must exist.
  EOT
  type        = string

  validation {
    condition     = var.resource_group_name != null && var.resource_group_name != ""
    error_message = "resource_group_name is required."
  }
}

variable "location" {
  description = <<-EOT
    (Required) The Azure region where the Route Server will be deployed.
    DEPENDENCY: Should match the Resource Group location.
  EOT
  type        = string

  validation {
    condition     = var.location != null && var.location != ""
    error_message = "location is required."
  }
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) The explicit name for the Route Server."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for generated name."
  type        = string
  default     = "rs"
}

variable "name_suffix" {
  description = "(Optional) Suffix for generated name."
  type        = string
  default     = ""
}

variable "workload" {
  description = "(Optional) Workload name for naming convention."
  type        = string
  default     = "default"
}

variable "environment" {
  description = "(Optional) Environment name."
  type        = string
  default     = "dev"
}

variable "instance" {
  description = "(Optional) Instance identifier."
  type        = string
  default     = "001"
}

################################################################################
# Route Server Configuration
################################################################################

variable "sku" {
  description = "(Optional) The SKU of the Route Server. Only 'Standard' is supported."
  type        = string
  default     = "Standard"

  validation {
    condition     = var.sku == "Standard"
    error_message = "sku must be 'Standard'."
  }
}

variable "subnet_id" {
  description = <<-EOT
    (Required) The ID of the subnet where the Route Server will be deployed.
    The subnet must be named 'RouteServerSubnet'.
    DEPENDENCY: Subnet named 'RouteServerSubnet' must exist in the target Virtual Network.
  EOT
  type        = string

  validation {
    condition     = var.subnet_id != null && var.subnet_id != ""
    error_message = "subnet_id is required and must reference a RouteServerSubnet."
  }
}

variable "public_ip_address_id" {
  description = <<-EOT
    (Optional) The ID of an existing Public IP to associate with the Route Server.
    If null, the module will create a new Standard SKU Public IP automatically.
    DEPENDENCY: If provided, the Public IP must exist and be Standard SKU with Static allocation.
  EOT
  type        = string
  default     = null
}

variable "branch_to_branch_traffic_enabled" {
  description = "(Optional) Whether to enable branch-to-branch traffic for the Route Server."
  type        = bool
  default     = false
}

################################################################################
# BGP Connections
################################################################################

variable "bgp_connections" {
  description = <<-EOT
    (Optional) A list of BGP connections (peerings) to configure on the Route Server.
    Each object requires:
      - name:     The name of the BGP connection.
      - peer_asn: The ASN of the BGP peer (NVA).
      - peer_ip:  The IP address of the BGP peer (NVA).
  EOT
  type = list(object({
    name     = string
    peer_asn = number
    peer_ip  = string
  }))
  default = []
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A map of tags to assign to resources."
  type        = map(string)
  default     = {}
}
