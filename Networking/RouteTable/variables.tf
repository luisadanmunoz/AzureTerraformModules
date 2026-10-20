################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Route Table."
  type        = bool
  default     = true
}

################################################################################
# Required Variables - Dependencies
################################################################################

variable "resource_group_name" {
  description = <<-EOT
    (Required) The name of the Resource Group where the Route Table will be created.
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
    (Required) The Azure region where the Route Table will be deployed.
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
  description = "(Optional) The explicit name for the Route Table."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for generated name."
  type        = string
  default     = "rt"
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
  description = "(Optional) Environment name (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "instance" {
  description = "(Optional) Instance identifier."
  type        = string
  default     = "001"
}

################################################################################
# Route Table Configuration
################################################################################

variable "bgp_route_propagation_enabled" {
  description = <<-EOT
    (Optional) Enable or disable BGP route propagation.
    Set to false to prevent learned routes from being added to the route table.
    Default is true.
  EOT
  type        = bool
  default     = true
}

################################################################################
# Routes
################################################################################

variable "routes" {
  description = <<-EOT
    (Optional) Map of routes to create in the Route Table.

    Attributes:
      - address_prefix: The destination CIDR (e.g., "0.0.0.0/0", "10.0.0.0/8").
      - next_hop_type: The type of next hop. Possible values:
        - "VirtualNetworkGateway"
        - "VnetLocal"
        - "Internet"
        - "VirtualAppliance"
        - "None"
      - next_hop_in_ip_address: The IP address of the next hop (required for VirtualAppliance).
        DEPENDENCY: The NVA/Firewall must exist and be reachable.
  EOT
  type = map(object({
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string, null)
  }))
  default = {}

  validation {
    condition = alltrue([
      for k, v in var.routes : contains([
        "VirtualNetworkGateway", "VnetLocal", "Internet", "VirtualAppliance", "None"
      ], v.next_hop_type)
    ])
    error_message = "next_hop_type must be one of: VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance, None."
  }

  validation {
    condition = alltrue([
      for k, v in var.routes : v.next_hop_type != "VirtualAppliance" || v.next_hop_in_ip_address != null
    ])
    error_message = "next_hop_in_ip_address is required when next_hop_type is 'VirtualAppliance'."
  }
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A map of tags to assign to the Route Table."
  type        = map(string)
  default     = {}
}
