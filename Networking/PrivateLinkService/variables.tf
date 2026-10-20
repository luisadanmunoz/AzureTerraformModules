################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Private Link Service."
  type        = bool
  default     = true
}

################################################################################
# Required Variables - Dependencies
################################################################################

variable "resource_group_name" {
  description = <<-EOT
    (Required) The name of the Resource Group where the Private Link Service will be created.
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
    (Required) The Azure region where the Private Link Service will be deployed.
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
  description = "(Optional) The explicit name for the Private Link Service."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for generated name."
  type        = string
  default     = "pls"
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
# Private Link Service Configuration
################################################################################

variable "load_balancer_frontend_ip_configuration_ids" {
  description = <<-EOT
    (Required) A list of Frontend IP Configuration IDs from a Standard Load Balancer
    that this Private Link Service will be associated with.
    DEPENDENCY: Standard Load Balancer with frontend IP configuration(s) must exist.
  EOT
  type        = list(string)

  validation {
    condition     = length(var.load_balancer_frontend_ip_configuration_ids) > 0
    error_message = "At least one load_balancer_frontend_ip_configuration_id is required."
  }
}

variable "nat_ip_configuration" {
  description = <<-EOT
    (Required) One or more NAT IP configuration blocks for the Private Link Service.
    Exactly one must be marked as primary.
    DEPENDENCY: Subnet(s) must exist with private link service network policies disabled.

    Attributes:
      - name: The name of the NAT IP configuration.
      - subnet_id: The ID of the Subnet to use for NAT IP configuration.
      - primary: Whether this is the primary NAT IP configuration.
      - private_ip_address: (Optional) A static private IP address for the NAT IP configuration.
      - private_ip_address_version: (Optional) The IP version for the private IP address (IPv4 or IPv6). Defaults to IPv4.
  EOT
  type = list(object({
    name                       = string
    subnet_id                  = string
    primary                    = bool
    private_ip_address         = optional(string, null)
    private_ip_address_version = optional(string, "IPv4")
  }))

  validation {
    condition     = length(var.nat_ip_configuration) > 0
    error_message = "At least one nat_ip_configuration is required."
  }

  validation {
    condition     = length([for c in var.nat_ip_configuration : c if c.primary]) == 1
    error_message = "Exactly one nat_ip_configuration must be marked as primary."
  }
}

variable "auto_approval_subscription_ids" {
  description = "(Optional) A list of Subscription IDs that are automatically approved to connect to the Private Link Service."
  type        = list(string)
  default     = null
}

variable "visibility_subscription_ids" {
  description = "(Optional) A list of Subscription IDs that are allowed to see the Private Link Service."
  type        = list(string)
  default     = null
}

variable "enable_proxy_protocol" {
  description = "(Optional) Whether to enable the Proxy Protocol on the Private Link Service. Defaults to false."
  type        = bool
  default     = false
}

variable "fqdns" {
  description = "(Optional) A list of FQDNs associated with the Private Link Service."
  type        = list(string)
  default     = null
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A map of tags to assign to resources."
  type        = map(string)
  default     = {}
}
