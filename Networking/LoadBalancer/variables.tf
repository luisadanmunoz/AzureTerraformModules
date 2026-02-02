################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Load Balancer."
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
  description = "(Optional) Explicit name for the Load Balancer."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for generated name."
  type        = string
  default     = "lb"
}

variable "workload" {
  description = "(Optional) Workload name."
  type        = string
  default     = "app"
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
# Load Balancer Configuration
################################################################################

variable "sku" {
  description = "(Optional) SKU: Basic, Standard, or Gateway."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard", "Gateway"], var.sku)
    error_message = "sku must be Basic, Standard, or Gateway."
  }
}

variable "sku_tier" {
  description = "(Optional) SKU tier: Regional or Global."
  type        = string
  default     = "Regional"

  validation {
    condition     = contains(["Regional", "Global"], var.sku_tier)
    error_message = "sku_tier must be Regional or Global."
  }
}

variable "type" {
  description = "(Optional) Load Balancer type: public or internal."
  type        = string
  default     = "public"

  validation {
    condition     = contains(["public", "internal"], var.type)
    error_message = "type must be public or internal."
  }
}

variable "edge_zone" {
  description = "(Optional) Edge Zone for the Load Balancer."
  type        = string
  default     = null
}

################################################################################
# Frontend IP Configuration
################################################################################

variable "frontend_ip_configurations" {
  description = <<-EOT
    (Required) Map of frontend IP configurations.

    For public LB:
      - public_ip_address_id: Existing Public IP ID.
      - public_ip_prefix_id: Public IP Prefix ID.
      - zones: Availability zones.

    For internal LB:
      - subnet_id: Subnet ID. DEPENDENCY: Must exist.
      - private_ip_address: Static IP from subnet.
      - private_ip_address_allocation: Static or Dynamic.
      - private_ip_address_version: IPv4 or IPv6.
  EOT
  type = map(object({
    public_ip_address_id          = optional(string, null)
    public_ip_prefix_id           = optional(string, null)
    subnet_id                     = optional(string, null)
    private_ip_address            = optional(string, null)
    private_ip_address_allocation = optional(string, "Dynamic")
    private_ip_address_version    = optional(string, "IPv4")
    zones                         = optional(list(string), null)
  }))
}

################################################################################
# Backend Address Pools
################################################################################

variable "backend_address_pools" {
  description = <<-EOT
    (Optional) Map of backend address pools.

    Attributes:
      - virtual_network_id: VNet ID for IP-based backends.
  EOT
  type = map(object({
    virtual_network_id = optional(string, null)
  }))
  default = {}
}

################################################################################
# Health Probes
################################################################################

variable "probes" {
  description = <<-EOT
    (Optional) Map of health probes.

    Attributes:
      - protocol: Tcp, Http, or Https.
      - port: Port to probe.
      - request_path: HTTP path (for Http/Https).
      - interval_in_seconds: Probe interval.
      - number_of_probes: Failures before unhealthy.
      - probe_threshold: Successes before healthy.
  EOT
  type = map(object({
    protocol            = string
    port                = number
    request_path        = optional(string, null)
    interval_in_seconds = optional(number, 5)
    number_of_probes    = optional(number, 2)
    probe_threshold     = optional(number, 1)
  }))
  default = {}
}

################################################################################
# Load Balancing Rules
################################################################################

variable "lb_rules" {
  description = <<-EOT
    (Optional) Map of load balancing rules.

    Attributes:
      - frontend_ip_configuration_name: Frontend config name.
      - backend_address_pool_ids: Backend pool IDs (use names, resolved in module).
      - probe_name: Health probe name.
      - protocol: Tcp, Udp, or All.
      - frontend_port: Frontend port.
      - backend_port: Backend port.
      - enable_floating_ip: Enable direct server return.
      - idle_timeout_in_minutes: TCP idle timeout.
      - load_distribution: Default, SourceIP, SourceIPProtocol.
      - disable_outbound_snat: Disable outbound SNAT.
      - enable_tcp_reset: Enable TCP reset on idle.
  EOT
  type = map(object({
    frontend_ip_configuration_name = string
    backend_address_pool_names     = list(string)
    probe_name                     = optional(string, null)
    protocol                       = string
    frontend_port                  = number
    backend_port                   = number
    enable_floating_ip             = optional(bool, false)
    idle_timeout_in_minutes        = optional(number, 4)
    load_distribution              = optional(string, "Default")
    disable_outbound_snat          = optional(bool, false)
    enable_tcp_reset               = optional(bool, true)
  }))
  default = {}
}

################################################################################
# NAT Rules
################################################################################

variable "nat_rules" {
  description = <<-EOT
    (Optional) Map of inbound NAT rules.

    Attributes:
      - frontend_ip_configuration_name: Frontend config name.
      - protocol: Tcp or Udp.
      - frontend_port: Frontend port (null for port range).
      - backend_port: Backend port.
      - frontend_port_start: Start of port range.
      - frontend_port_end: End of port range.
      - backend_address_pool_id: For NAT pool rules.
      - idle_timeout_in_minutes: TCP idle timeout.
      - enable_floating_ip: Enable direct server return.
      - enable_tcp_reset: Enable TCP reset on idle.
  EOT
  type = map(object({
    frontend_ip_configuration_name = string
    protocol                       = string
    frontend_port                  = optional(number, null)
    backend_port                   = number
    frontend_port_start            = optional(number, null)
    frontend_port_end              = optional(number, null)
    backend_address_pool_id        = optional(string, null)
    idle_timeout_in_minutes        = optional(number, 4)
    enable_floating_ip             = optional(bool, false)
    enable_tcp_reset               = optional(bool, true)
  }))
  default = {}
}

################################################################################
# Outbound Rules (Standard SKU only)
################################################################################

variable "outbound_rules" {
  description = <<-EOT
    (Optional) Map of outbound rules (Standard SKU only).

    Attributes:
      - frontend_ip_configuration_names: Frontend config names.
      - backend_address_pool_id: Backend pool name (resolved in module).
      - protocol: Tcp, Udp, or All.
      - allocated_outbound_ports: Ports per instance.
      - idle_timeout_in_minutes: TCP idle timeout.
      - enable_tcp_reset: Enable TCP reset on idle.
  EOT
  type = map(object({
    frontend_ip_configuration_names = list(string)
    backend_address_pool_name       = string
    protocol                        = string
    allocated_outbound_ports        = optional(number, 1024)
    idle_timeout_in_minutes         = optional(number, 4)
    enable_tcp_reset                = optional(bool, true)
  }))
  default = {}
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
    name                       = optional(string, "diag-lb")
    log_analytics_workspace_id = optional(string, null)
    storage_account_id         = optional(string, null)
    metric_categories          = optional(list(string), ["AllMetrics"])
  })
  default = null
}
