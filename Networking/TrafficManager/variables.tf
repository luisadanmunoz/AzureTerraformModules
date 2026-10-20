################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Traffic Manager profile."
  type        = bool
  default     = true
}

################################################################################
# Required Variables
################################################################################

variable "resource_group_name" {
  description = <<-EOT
    (Required) The name of the Resource Group where the Traffic Manager profile will be created.
    DEPENDENCY: Resource Group must exist before creating the Traffic Manager profile.
  EOT
  type        = string

  validation {
    condition     = var.resource_group_name != null && var.resource_group_name != ""
    error_message = "resource_group_name is required and cannot be empty."
  }
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) Explicit name for the Traffic Manager profile. If provided, overrides generated name."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for generated name."
  type        = string
  default     = "tm"
}

variable "workload" {
  description = "(Optional) Workload or purpose name, used for naming convention."
  type        = string
  default     = "app"
}

variable "environment" {
  description = "(Optional) Environment name (e.g., dev, staging, prod)."
  type        = string
  default     = "prod"
}

variable "instance" {
  description = "(Optional) Instance identifier."
  type        = string
  default     = "001"
}

################################################################################
# Traffic Manager Profile Configuration
################################################################################

variable "profile_status" {
  description = "(Optional) The status of the Traffic Manager profile. Possible values: Enabled, Disabled."
  type        = string
  default     = "Enabled"

  validation {
    condition     = contains(["Enabled", "Disabled"], var.profile_status)
    error_message = "profile_status must be either 'Enabled' or 'Disabled'."
  }
}

variable "traffic_routing_method" {
  description = <<-EOT
    (Optional) The traffic routing method for the profile.
    Possible values: Performance, Priority, Weighted, Geographic, MultiValue, Subnet.
  EOT
  type        = string
  default     = "Performance"

  validation {
    condition     = contains(["Performance", "Priority", "Weighted", "Geographic", "MultiValue", "Subnet"], var.traffic_routing_method)
    error_message = "traffic_routing_method must be one of: Performance, Priority, Weighted, Geographic, MultiValue, Subnet."
  }
}

variable "dns_config_relative_name" {
  description = <<-EOT
    (Optional) The relative DNS name for the Traffic Manager profile.
    This forms the FQDN: <relative_name>.trafficmanager.net.
    If not set, the profile name is used.
  EOT
  type        = string
  default     = null
}

variable "dns_config_ttl" {
  description = "(Optional) The DNS Time-To-Live (TTL) in seconds. Default is 60."
  type        = number
  default     = 60

  validation {
    condition     = var.dns_config_ttl >= 0 && var.dns_config_ttl <= 2147483647
    error_message = "dns_config_ttl must be a non-negative integer."
  }
}

variable "max_return" {
  description = <<-EOT
    (Optional) The maximum number of endpoints returned for MultiValue routing.
    Only applicable when traffic_routing_method is MultiValue.
  EOT
  type        = number
  default     = null
}

variable "traffic_view_enabled" {
  description = "(Optional) Whether Traffic View is enabled for the profile."
  type        = bool
  default     = false
}

################################################################################
# Monitor Configuration
################################################################################

variable "monitor_config" {
  description = <<-EOT
    (Optional) Monitor configuration for the Traffic Manager profile.

    Attributes:
      - protocol: Protocol for health checks (HTTP, HTTPS, TCP).
      - port: Port number for health checks.
      - path: Path for HTTP/HTTPS health checks.
      - interval_in_seconds: Probing interval in seconds (10 or 30).
      - timeout_in_seconds: Probe timeout in seconds.
      - tolerated_number_of_failures: Number of consecutive failures before endpoint is degraded.
      - expected_status_code_ranges: List of expected status code ranges (e.g., "200-299").
      - custom_header: List of custom headers for health checks.
  EOT
  type = object({
    protocol                     = optional(string, "HTTPS")
    port                         = optional(number, 443)
    path                         = optional(string, "/")
    interval_in_seconds          = optional(number, 30)
    timeout_in_seconds           = optional(number, 10)
    tolerated_number_of_failures = optional(number, 3)
    expected_status_code_ranges  = optional(list(string), null)
    custom_header = optional(list(object({
      name  = string
      value = string
    })), null)
  })
  default = {}
}

################################################################################
# Endpoints
################################################################################

variable "endpoints" {
  description = <<-EOT
    (Optional) List of Traffic Manager endpoints.

    Attributes:
      - name: The name of the endpoint.
      - type: The type of endpoint. Possible values: azureEndpoints, externalEndpoints, nestedEndpoints.
      - target_resource_id: The resource ID of the Azure target (for azureEndpoints/nestedEndpoints).
        DEPENDENCY: Target resource must exist.
      - target: The FQDN of the external endpoint (for externalEndpoints).
      - weight: The weight of the endpoint (1-1000, for Weighted routing).
      - priority: The priority of the endpoint (1-1000, for Priority routing).
      - endpoint_location: The location of the endpoint (required for Performance/Geographic routing with external/nested endpoints).
      - min_child_endpoints: Minimum child endpoints for nested endpoint to be considered healthy.
      - min_child_endpoints_ipv4: Minimum IPv4 child endpoints for nested endpoint.
      - min_child_endpoints_ipv6: Minimum IPv6 child endpoints for nested endpoint.
      - geo_mappings: List of geographic mappings (for Geographic routing).
      - subnet: List of subnet objects with first, last, and scope for Subnet routing.
      - custom_header: List of custom header objects with name and value.
      - enabled: Whether the endpoint is enabled.
  EOT
  type = list(object({
    name                        = string
    type                        = string
    target_resource_id          = optional(string, null)
    target                      = optional(string, null)
    weight                      = optional(number, null)
    priority                    = optional(number, null)
    endpoint_location           = optional(string, null)
    min_child_endpoints         = optional(number, null)
    min_child_endpoints_ipv4    = optional(number, null)
    min_child_endpoints_ipv6    = optional(number, null)
    geo_mappings                = optional(list(string), null)
    subnet = optional(list(object({
      first = string
      last  = optional(string, null)
      scope = optional(number, null)
    })), null)
    custom_header = optional(list(object({
      name  = string
      value = string
    })), null)
    enabled = optional(bool, true)
  }))
  default = []

  validation {
    condition = alltrue([
      for ep in var.endpoints : contains(["azureEndpoints", "externalEndpoints", "nestedEndpoints"], ep.type)
    ])
    error_message = "Each endpoint type must be one of: azureEndpoints, externalEndpoints, nestedEndpoints."
  }
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A map of tags to assign to resources."
  type        = map(string)
  default     = {}
}

################################################################################
# Diagnostic Settings
################################################################################

variable "diagnostic_settings" {
  description = <<-EOT
    (Optional) Diagnostic settings configuration for the Traffic Manager profile.
    DEPENDENCY: Log Analytics Workspace, Storage Account, or Event Hub must exist.
  EOT
  type = object({
    name                           = optional(string, "diag-tm")
    log_analytics_workspace_id     = optional(string, null)
    storage_account_id             = optional(string, null)
    eventhub_authorization_rule_id = optional(string, null)
    eventhub_name                  = optional(string, null)
    log_categories                 = optional(list(string), ["ProbeHealthStatusEvents"])
    metric_categories              = optional(list(string), ["AllMetrics"])
  })
  default = null
}
