################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Application Gateway."
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

variable "subnet_id" {
  description = <<-EOT
    (Required) Subnet ID for the Application Gateway.
    DEPENDENCY: Dedicated subnet must exist (recommended /24, minimum /26).
  EOT
  type        = string
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) Explicit name for the Application Gateway."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for generated name."
  type        = string
  default     = "agw"
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

variable "sku" {
  description = <<-EOT
    (Required) SKU configuration.

    Attributes:
      - name: Standard_v2, WAF_v2, Standard_Small, Standard_Medium, Standard_Large, WAF_Medium, WAF_Large
      - tier: Standard_v2, WAF_v2, Standard, WAF
      - capacity: Instance count (1-125 for v2 without autoscale, 1-32 for v1)
  EOT
  type = object({
    name     = string
    tier     = string
    capacity = optional(number, null)
  })
  default = {
    name = "Standard_v2"
    tier = "Standard_v2"
  }
}

variable "autoscale_configuration" {
  description = <<-EOT
    (Optional) Autoscale configuration (v2 SKU only).

    Attributes:
      - min_capacity: Minimum instances (0-100).
      - max_capacity: Maximum instances (2-125).
  EOT
  type = object({
    min_capacity = number
    max_capacity = optional(number, 10)
  })
  default = null
}

variable "zones" {
  description = "(Optional) Availability zones for the Application Gateway."
  type        = list(string)
  default     = ["1", "2", "3"]
}

################################################################################
# Gateway IP Configuration
################################################################################

variable "gateway_ip_configuration_name" {
  description = "(Optional) Name of the gateway IP configuration."
  type        = string
  default     = "gateway-ip-config"
}

################################################################################
# Frontend Configuration
################################################################################

variable "public_ip_id" {
  description = <<-EOT
    (Optional) Existing Public IP ID. If not provided, a new one will be created.
    DEPENDENCY: Must be Standard SKU, Static allocation.
  EOT
  type        = string
  default     = null
}

variable "private_ip_address" {
  description = "(Optional) Private IP address for private frontend (from subnet range)."
  type        = string
  default     = null
}

variable "private_ip_address_allocation" {
  description = "(Optional) Private IP allocation method: Static or Dynamic."
  type        = string
  default     = "Dynamic"
}

################################################################################
# Frontend Ports
################################################################################

variable "frontend_ports" {
  description = <<-EOT
    (Required) Map of frontend ports.
    Example: { "http" = 80, "https" = 443 }
  EOT
  type        = map(number)
  default = {
    "http"  = 80
    "https" = 443
  }
}

################################################################################
# Backend Address Pools
################################################################################

variable "backend_address_pools" {
  description = <<-EOT
    (Required) Map of backend address pools.

    Attributes:
      - fqdns: List of FQDNs.
      - ip_addresses: List of IP addresses.
  EOT
  type = map(object({
    fqdns        = optional(list(string), [])
    ip_addresses = optional(list(string), [])
  }))
}

################################################################################
# Backend HTTP Settings
################################################################################

variable "backend_http_settings" {
  description = <<-EOT
    (Required) Map of backend HTTP settings.

    Attributes:
      - port: Backend port.
      - protocol: Http or Https.
      - cookie_based_affinity: Enabled or Disabled.
      - request_timeout: Timeout in seconds.
      - pick_host_name_from_backend_address: Use backend FQDN as host header.
      - host_name: Custom host header.
      - path: Path prefix.
      - probe_name: Associated probe name.
      - trusted_root_certificate_names: For HTTPS backends.
  EOT
  type = map(object({
    port                                = number
    protocol                            = string
    cookie_based_affinity               = optional(string, "Disabled")
    request_timeout                     = optional(number, 30)
    pick_host_name_from_backend_address = optional(bool, false)
    host_name                           = optional(string, null)
    path                                = optional(string, null)
    probe_name                          = optional(string, null)
    trusted_root_certificate_names      = optional(list(string), [])
  }))
}

################################################################################
# HTTP Listeners
################################################################################

variable "http_listeners" {
  description = <<-EOT
    (Required) Map of HTTP listeners.

    Attributes:
      - frontend_ip_configuration_name: public or private.
      - frontend_port_name: Port name from frontend_ports.
      - protocol: Http or Https.
      - ssl_certificate_name: Certificate name (for HTTPS).
      - host_name: Host header for multi-site.
      - host_names: Multiple host headers.
      - require_sni: Require SNI (HTTPS only).
  EOT
  type = map(object({
    frontend_ip_configuration_name = optional(string, "public")
    frontend_port_name             = string
    protocol                       = string
    ssl_certificate_name           = optional(string, null)
    host_name                      = optional(string, null)
    host_names                     = optional(list(string), null)
    require_sni                    = optional(bool, false)
  }))
}

################################################################################
# Request Routing Rules
################################################################################

variable "request_routing_rules" {
  description = <<-EOT
    (Required) Map of routing rules.

    Attributes:
      - rule_type: Basic or PathBasedRouting.
      - priority: Rule priority (1-20000).
      - http_listener_name: Listener name.
      - backend_address_pool_name: Backend pool name (Basic rules).
      - backend_http_settings_name: HTTP settings name (Basic rules).
      - url_path_map_name: URL path map name (PathBased rules).
      - redirect_configuration_name: Redirect config name.
      - rewrite_rule_set_name: Rewrite rule set name.
  EOT
  type = map(object({
    rule_type                   = string
    priority                    = number
    http_listener_name          = string
    backend_address_pool_name   = optional(string, null)
    backend_http_settings_name  = optional(string, null)
    url_path_map_name           = optional(string, null)
    redirect_configuration_name = optional(string, null)
    rewrite_rule_set_name       = optional(string, null)
  }))
}

################################################################################
# Health Probes (Optional)
################################################################################

variable "probes" {
  description = <<-EOT
    (Optional) Map of health probes.

    Attributes:
      - protocol: Http or Https.
      - path: Probe path.
      - host: Host header.
      - interval: Probe interval in seconds.
      - timeout: Timeout in seconds.
      - unhealthy_threshold: Failures before unhealthy.
      - pick_host_name_from_backend_http_settings: Use backend host.
      - minimum_servers: Minimum healthy servers.
      - match: Response match criteria.
  EOT
  type = map(object({
    protocol                                  = string
    path                                      = string
    host                                      = optional(string, null)
    interval                                  = optional(number, 30)
    timeout                                   = optional(number, 30)
    unhealthy_threshold                       = optional(number, 3)
    pick_host_name_from_backend_http_settings = optional(bool, false)
    minimum_servers                           = optional(number, 0)
    match = optional(object({
      body        = optional(string, null)
      status_code = list(string)
    }), null)
  }))
  default = {}
}

################################################################################
# SSL Certificates (Optional)
################################################################################

variable "ssl_certificates" {
  description = <<-EOT
    (Optional) Map of SSL certificates.
    DEPENDENCY: Key Vault certificate or PFX file must exist.

    Attributes:
      - data: Base64-encoded PFX certificate.
      - password: PFX password.
      - key_vault_secret_id: Key Vault secret ID (preferred).
  EOT
  type = map(object({
    data                = optional(string, null)
    password            = optional(string, null)
    key_vault_secret_id = optional(string, null)
  }))
  default   = {}
  sensitive = true
}

################################################################################
# WAF Configuration (Optional)
################################################################################

variable "waf_configuration" {
  description = <<-EOT
    (Optional) WAF configuration (WAF/WAF_v2 SKU only).

    Attributes:
      - enabled: Enable WAF.
      - firewall_mode: Detection or Prevention.
      - rule_set_type: OWASP or Microsoft_BotManagerRuleSet.
      - rule_set_version: Rule set version (3.2, 3.1, 3.0, 2.2.9).
      - file_upload_limit_mb: Max upload size (1-750 MB).
      - request_body_check: Enable body inspection.
      - max_request_body_size_kb: Max body size (1-128 KB).
      - disabled_rule_groups: Rules to disable.
      - exclusions: WAF exclusions.
  EOT
  type = object({
    enabled                  = optional(bool, true)
    firewall_mode            = optional(string, "Prevention")
    rule_set_type            = optional(string, "OWASP")
    rule_set_version         = optional(string, "3.2")
    file_upload_limit_mb     = optional(number, 100)
    request_body_check       = optional(bool, true)
    max_request_body_size_kb = optional(number, 128)
    disabled_rule_groups = optional(list(object({
      rule_group_name = string
      rules           = optional(list(string), [])
    })), [])
    exclusions = optional(list(object({
      match_variable          = string
      selector_match_operator = optional(string, null)
      selector                = optional(string, null)
    })), [])
  })
  default = null
}

variable "firewall_policy_id" {
  description = <<-EOT
    (Optional) WAF Policy ID (alternative to waf_configuration).
    DEPENDENCY: WAF Policy must exist.
  EOT
  type        = string
  default     = null
}

################################################################################
# Identity (Optional)
################################################################################

variable "identity" {
  description = <<-EOT
    (Optional) Managed identity for Key Vault access.
    DEPENDENCY: User-assigned identity must exist.
  EOT
  type = object({
    type         = optional(string, "UserAssigned")
    identity_ids = list(string)
  })
  default = null
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
    name                           = optional(string, "diag-agw")
    log_analytics_workspace_id     = optional(string, null)
    storage_account_id             = optional(string, null)
    eventhub_authorization_rule_id = optional(string, null)
    log_categories = optional(list(string), [
      "ApplicationGatewayAccessLog",
      "ApplicationGatewayPerformanceLog",
      "ApplicationGatewayFirewallLog"
    ])
    metric_categories = optional(list(string), ["AllMetrics"])
  })
  default = null
}
