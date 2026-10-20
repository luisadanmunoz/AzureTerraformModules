#############################################################################
# VARIABLES LOAD BALANCER
#############################################################################
variable "load_balancer_name" {
  description = "value to set the load balancer name"
  type        = string

  validation {
    condition     = trimspace(var.load_balancer_name) != ""
    error_message = "load_balancer_name must not be empty."
  }
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "location" {
  description = "value to set the location"
  type        = string

  validation {
    condition     = trimspace(var.location) != ""
    error_message = "location must not be empty."
  }
}

variable "sku" {
  description = "value to set the load balancer sku"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Gateway", "Standard"], var.sku)
    error_message = "sku must be one of Basic, Gateway or Standard."
  }
}

variable "sku_tier" {
  description = "value to set the load balancer sku tier"
  type        = string
  default     = "Regional"

  validation {
    condition     = contains(["Global", "Regional"], var.sku_tier)
    error_message = "sku_tier must be Global or Regional."
  }
}

variable "edge_zone" {
  description = "value to set the edge zone"
  type        = string
  default     = null
}

variable "frontend_ip_configurations" {
  description = "value to set the frontend ip configurations"
  type = list(object({
    name                          = string
    subnet_id                     = optional(string)
    private_ip_address            = optional(string)
    private_ip_address_allocation = optional(string)
    private_ip_address_version    = optional(string)
    public_ip_address_id          = optional(string)
    public_ip_prefix_id           = optional(string)
    zones                         = optional(list(string))
  }))

  validation {
    condition = length(var.frontend_ip_configurations) > 0 && alltrue([
      for configuration in var.frontend_ip_configurations :
      try(configuration.public_ip_address_id, null) != null ||
      try(configuration.public_ip_prefix_id, null) != null ||
      try(configuration.subnet_id, null) != null ||
      try(configuration.private_ip_address, null) != null
    ])
    error_message = "At least one frontend_ip_configuration is required and each one must define a public or private frontend target."
  }
}

variable "backend_address_pools" {
  description = "value to set the backend address pools"
  type = list(object({
    name = string
  }))
  default = []
}

variable "probes" {
  description = "value to set the probes"
  type = list(object({
    name                = string
    protocol            = string
    port                = number
    request_path        = optional(string)
    interval_in_seconds = optional(number)
    number_of_probes    = optional(number)
  }))
  default = []
}

variable "rules" {
  description = "value to set the rules"
  type = list(object({
    name                           = string
    protocol                       = string
    frontend_port                  = number
    backend_port                   = number
    frontend_ip_configuration_name = string
    backend_address_pool_name      = optional(string)
    probe_name                     = optional(string)
    enable_floating_ip             = optional(bool)
    idle_timeout_in_minutes        = optional(number)
    load_distribution              = optional(string)
    disable_outbound_snat          = optional(bool)
    tcp_reset_enabled              = optional(bool)
  }))
  default = []
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
