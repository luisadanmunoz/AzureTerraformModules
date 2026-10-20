################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Front Door profile and associated resources."
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

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) Explicit name for the Front Door profile. Overrides generated name."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for generated name."
  type        = string
  default     = "afd"
}

variable "workload" {
  description = "(Optional) Workload name."
  type        = string
  default     = "web"
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
# SKU Configuration
################################################################################

variable "sku_name" {
  description = <<-EOT
    (Optional) SKU name for the Front Door profile.

    Allowed values:
      - Standard_AzureFrontDoor: Standard tier with basic CDN/routing capabilities.
      - Premium_AzureFrontDoor:  Premium tier with WAF, Private Link, and advanced features.
  EOT
  type        = string
  default     = "Standard_AzureFrontDoor"

  validation {
    condition     = contains(["Standard_AzureFrontDoor", "Premium_AzureFrontDoor"], var.sku_name)
    error_message = "sku_name must be either 'Standard_AzureFrontDoor' or 'Premium_AzureFrontDoor'."
  }
}

################################################################################
# Profile Configuration
################################################################################

variable "response_timeout_seconds" {
  description = "(Optional) Specifies the maximum response timeout in seconds. Possible values are between 16 and 240 seconds."
  type        = number
  default     = 120

  validation {
    condition     = var.response_timeout_seconds >= 16 && var.response_timeout_seconds <= 240
    error_message = "response_timeout_seconds must be between 16 and 240."
  }
}

################################################################################
# Endpoints
################################################################################

variable "endpoints" {
  description = <<-EOT
    (Optional) List of Front Door endpoints.

    Attributes:
      - name:    Unique name for the endpoint.
      - enabled: Whether the endpoint is enabled. Defaults to true.
  EOT
  type = list(object({
    name    = string
    enabled = optional(bool, true)
  }))
  default = []
}

################################################################################
# Origin Groups
################################################################################

variable "origin_groups" {
  description = <<-EOT
    (Optional) List of Front Door origin groups.

    Attributes:
      - name:                          Unique name for the origin group.
      - session_affinity_enabled:      Enable session affinity. Defaults to false.
      - restore_traffic_time_to_healed_or_new_endpoint_in_minutes:
          Time in minutes to shift traffic to a healed or new endpoint. Defaults to 10.
      - health_probe:                  Health probe settings (optional).
        - interval_in_seconds:         Probe interval (5-31536000). Defaults to 100.
        - path:                        Probe path. Defaults to "/".
        - protocol:                    Http or Https. Defaults to "Https".
        - request_type:                GET or HEAD. Defaults to "HEAD".
      - load_balancing:                Load balancing settings.
        - additional_latency_in_milliseconds: Extra latency threshold. Defaults to 50.
        - sample_size:                 Number of samples. Defaults to 4.
        - successful_samples_required: Successful samples needed. Defaults to 3.
  EOT
  type = list(object({
    name                                                          = string
    session_affinity_enabled                                      = optional(bool, false)
    restore_traffic_time_to_healed_or_new_endpoint_in_minutes     = optional(number, 10)
    health_probe = optional(object({
      interval_in_seconds = optional(number, 100)
      path                = optional(string, "/")
      protocol            = optional(string, "Https")
      request_type        = optional(string, "HEAD")
    }), null)
    load_balancing = optional(object({
      additional_latency_in_milliseconds = optional(number, 50)
      sample_size                        = optional(number, 4)
      successful_samples_required        = optional(number, 3)
    }), {})
  }))
  default = []
}

################################################################################
# Origins
################################################################################

variable "origins" {
  description = <<-EOT
    (Optional) List of Front Door origins.

    Attributes:
      - name:                            Unique name for the origin.
      - origin_group_name:               Name of the origin group this origin belongs to.
      - host_name:                       The hostname/IP of the origin.
      - http_port:                       HTTP port. Defaults to 80.
      - https_port:                      HTTPS port. Defaults to 443.
      - origin_host_header:              Host header sent to the origin. Defaults to host_name.
      - priority:                        Priority (1-5). Defaults to 1.
      - weight:                          Weight (1-1000). Defaults to 1000.
      - enabled:                         Whether the origin is enabled. Defaults to true.
      - certificate_name_check_enabled:  Whether certificate name check is enabled. Defaults to true.
      - private_link:                    Private Link configuration (Premium SKU only, optional).
        - request_message:               Approval request message.
        - target_type:                   Target type (e.g., "blob", "sites").
        - location:                      Azure region of the Private Link resource.
        - private_link_target_id:        Resource ID of the Private Link target.
          DEPENDENCY: Private Link target must exist.
  EOT
  type = list(object({
    name                           = string
    origin_group_name              = string
    host_name                      = string
    http_port                      = optional(number, 80)
    https_port                     = optional(number, 443)
    origin_host_header             = optional(string, null)
    priority                       = optional(number, 1)
    weight                         = optional(number, 1000)
    enabled                        = optional(bool, true)
    certificate_name_check_enabled = optional(bool, true)
    private_link = optional(object({
      request_message        = optional(string, "Please approve this Private Link connection.")
      target_type            = optional(string, null)
      location               = string
      private_link_target_id = string
    }), null)
  }))
  default = []
}

################################################################################
# Routes
################################################################################

variable "routes" {
  description = <<-EOT
    (Optional) List of Front Door routes.

    Attributes:
      - name:                    Unique name for the route.
      - endpoint_name:           Name of the endpoint this route is associated with.
      - origin_group_name:       Name of the origin group for this route.
      - origin_names:            List of origin names within the origin group.
      - patterns_to_match:       URL patterns to match. Defaults to ["/*"].
      - supported_protocols:     List of supported protocols. Defaults to ["Http", "Https"].
      - forwarding_protocol:     Forwarding protocol: HttpOnly, HttpsOnly, or MatchRequest. Defaults to "HttpsOnly".
      - https_redirect_enabled:  Redirect HTTP to HTTPS. Defaults to true.
      - link_to_default_domain:  Link to the default (.azurefd.net) domain. Defaults to true.
      - cache:                   Cache configuration (optional).
        - query_string_caching_behavior: IgnoreQueryString, UseQueryString, IgnoreSpecifiedQueryStrings, IncludeSpecifiedQueryStrings. Defaults to "IgnoreQueryString".
        - query_strings:                 List of query string parameters.
        - compression_enabled:           Enable compression. Defaults to false.
        - content_types_to_compress:     List of MIME types to compress.
  EOT
  type = list(object({
    name                   = string
    endpoint_name          = string
    origin_group_name      = string
    origin_names           = optional(list(string), [])
    patterns_to_match      = optional(list(string), ["/*"])
    supported_protocols    = optional(list(string), ["Http", "Https"])
    forwarding_protocol    = optional(string, "HttpsOnly")
    https_redirect_enabled = optional(bool, true)
    link_to_default_domain = optional(bool, true)
    cache = optional(object({
      query_string_caching_behavior = optional(string, "IgnoreQueryString")
      query_strings                 = optional(list(string), [])
      compression_enabled           = optional(bool, false)
      content_types_to_compress     = optional(list(string), [])
    }), null)
  }))
  default = []
}

################################################################################
# Custom Domains (Optional)
################################################################################

variable "custom_domains" {
  description = <<-EOT
    (Optional) List of custom domains to associate with the Front Door profile.

    Attributes:
      - name:      Unique name for the custom domain resource.
      - host_name: The FQDN of the custom domain.
      - tls:       TLS configuration (optional).
        - certificate_type:    ManagedCertificate or CustomerCertificate. Defaults to "ManagedCertificate".
        - minimum_tls_version: TLS1_0, TLS1_2. Defaults to "TLS12".
        - cdn_frontdoor_secret_id: Secret ID for CustomerCertificate type.
          DEPENDENCY: Secret must exist when using CustomerCertificate.
  EOT
  type = list(object({
    name      = string
    host_name = string
    tls = optional(object({
      certificate_type        = optional(string, "ManagedCertificate")
      minimum_tls_version     = optional(string, "TLS12")
      cdn_frontdoor_secret_id = optional(string, null)
    }), {})
  }))
  default = []
}

################################################################################
# Security Policies (Optional)
################################################################################

variable "security_policies" {
  description = <<-EOT
    (Optional) List of security policies to associate with the Front Door profile.
    DEPENDENCY: Firewall policy must exist.

    Attributes:
      - name:               Unique name for the security policy.
      - patterns_to_match:  List of endpoint/domain association patterns (e.g., endpoint IDs, domain IDs).
      - firewall_policy_id: Resource ID of the Front Door Firewall Policy.
  EOT
  type = list(object({
    name               = string
    patterns_to_match  = list(string)
    firewall_policy_id = string
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

################################################################################
# Diagnostic Settings
################################################################################

variable "diagnostic_settings" {
  description = <<-EOT
    (Optional) Diagnostic settings configuration.
    DEPENDENCY: Log Analytics workspace and/or Storage account must exist.
  EOT
  type = object({
    name                           = optional(string, "diag-afd")
    log_analytics_workspace_id     = optional(string, null)
    storage_account_id             = optional(string, null)
    eventhub_authorization_rule_id = optional(string, null)
    log_categories = optional(list(string), [
      "FrontDoorAccessLog",
      "FrontDoorHealthProbeLog",
      "FrontDoorWebApplicationFirewallLog"
    ])
    metric_categories = optional(list(string), ["AllMetrics"])
  })
  default = null
}
