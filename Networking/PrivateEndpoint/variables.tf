################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Private Endpoint."
  type        = bool
  default     = true
}

################################################################################
# Required Variables - Dependencies
################################################################################

variable "resource_group_name" {
  description = <<-EOT
    (Required) The name of the Resource Group where the Private Endpoint will be created.
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
    (Required) The Azure region where the Private Endpoint will be deployed.
    DEPENDENCY: Should match the Resource Group and Subnet location.
  EOT
  type        = string

  validation {
    condition     = var.location != null && var.location != ""
    error_message = "location is required."
  }
}

variable "subnet_id" {
  description = <<-EOT
    (Required) The ID of the Subnet where the Private Endpoint will be created.
    DEPENDENCY: Subnet must exist with private endpoint policies disabled.
  EOT
  type        = string

  validation {
    condition     = var.subnet_id != null && var.subnet_id != ""
    error_message = "subnet_id is required."
  }
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) The explicit name for the Private Endpoint."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for generated name."
  type        = string
  default     = "pe"
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
# Private Endpoint Configuration
################################################################################

variable "private_service_connection" {
  description = <<-EOT
    (Required) The private service connection configuration.
    DEPENDENCY: Target resource must exist and support private endpoints.

    Attributes:
      - name: A name for the private service connection.
      - private_connection_resource_id: The ID of the resource to connect to.
      - is_manual_connection: Whether manual approval is required (false for owned resources).
      - subresource_names: List of subresource names (e.g., ["blob"], ["sqlServer"]).
      - request_message: Request message for manual connections.
  EOT
  type = object({
    name                           = optional(string, "psc")
    private_connection_resource_id = string
    is_manual_connection           = optional(bool, false)
    subresource_names              = optional(list(string), null)
    request_message                = optional(string, null)
  })

  validation {
    condition     = var.private_service_connection.private_connection_resource_id != null
    error_message = "private_connection_resource_id is required."
  }
}

variable "custom_network_interface_name" {
  description = "(Optional) Custom name for the network interface."
  type        = string
  default     = null
}

variable "private_dns_zone_group" {
  description = <<-EOT
    (Optional) Private DNS Zone Group configuration for automatic DNS registration.
    DEPENDENCY: Private DNS Zone(s) must exist.

    Attributes:
      - name: Name for the DNS zone group.
      - private_dns_zone_ids: List of Private DNS Zone IDs.
  EOT
  type = object({
    name                 = optional(string, "default")
    private_dns_zone_ids = list(string)
  })
  default = null
}

variable "ip_configuration" {
  description = <<-EOT
    (Optional) Static IP configuration for the private endpoint.
    By default, a dynamic IP is assigned from the subnet.

    Attributes:
      - name: Name for the IP configuration.
      - subresource_name: Subresource name (must match subresource_names).
      - member_name: Member name (e.g., "default").
      - private_ip_address: Static private IP address.
  EOT
  type = list(object({
    name               = string
    subresource_name   = optional(string, null)
    member_name        = optional(string, "default")
    private_ip_address = string
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
