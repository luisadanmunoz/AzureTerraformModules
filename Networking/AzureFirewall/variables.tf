################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Azure Firewall."
  type        = bool
  default     = true
}

################################################################################
# Required Variables - Dependencies
################################################################################

variable "resource_group_name" {
  description = <<-EOT
    (Required) The name of the Resource Group where the Azure Firewall will be created.
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
    (Required) The Azure region where the Azure Firewall will be deployed.
    DEPENDENCY: Should match the Resource Group and VNet location.
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
  description = "(Optional) The explicit name for the Azure Firewall."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for generated name."
  type        = string
  default     = "afw"
}

variable "name_suffix" {
  description = "(Optional) Suffix for generated name."
  type        = string
  default     = ""
}

variable "workload" {
  description = "(Optional) Workload name for naming convention."
  type        = string
  default     = "hub"
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
# Azure Firewall Configuration
################################################################################

variable "sku_name" {
  description = <<-EOT
    (Optional) The SKU name of the Azure Firewall.
    Possible values: "AZFW_Hub", "AZFW_VNet".
    Use "AZFW_Hub" for Virtual WAN Hub, "AZFW_VNet" for VNet deployment.
  EOT
  type        = string
  default     = "AZFW_VNet"

  validation {
    condition     = contains(["AZFW_Hub", "AZFW_VNet"], var.sku_name)
    error_message = "sku_name must be either 'AZFW_Hub' or 'AZFW_VNet'."
  }
}

variable "sku_tier" {
  description = <<-EOT
    (Optional) The SKU tier of the Azure Firewall.
    Possible values: "Basic", "Standard", "Premium".
    - Basic: Cost-effective for small workloads (limited features)
    - Standard: Full L3-L7 filtering, threat intelligence
    - Premium: Adds TLS inspection, IDPS, URL filtering
  EOT
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku_tier)
    error_message = "sku_tier must be 'Basic', 'Standard', or 'Premium'."
  }
}

variable "firewall_policy_id" {
  description = <<-EOT
    (Optional) The ID of the Firewall Policy to associate.
    DEPENDENCY: Firewall Policy must exist. Recommended over classic rules.
  EOT
  type        = string
  default     = null
}

variable "dns_servers" {
  description = "(Optional) List of custom DNS servers. If not set, uses Azure DNS."
  type        = list(string)
  default     = null
}

variable "dns_proxy_enabled" {
  description = "(Optional) Enable DNS Proxy. Required for FQDN filtering in network rules."
  type        = bool
  default     = true
}

variable "threat_intel_mode" {
  description = <<-EOT
    (Optional) Threat Intelligence mode.
    Possible values: "Off", "Alert", "Deny".
    - Off: Disabled
    - Alert: Log only
    - Deny: Block malicious traffic
  EOT
  type        = string
  default     = "Alert"

  validation {
    condition     = contains(["Off", "Alert", "Deny"], var.threat_intel_mode)
    error_message = "threat_intel_mode must be 'Off', 'Alert', or 'Deny'."
  }
}

variable "private_ip_ranges" {
  description = <<-EOT
    (Optional) List of SNAT private IP ranges.
    Use "IANAPrivateRanges" to SNAT only when destination is public.
  EOT
  type        = list(string)
  default     = null
}

variable "zones" {
  description = <<-EOT
    (Optional) Availability zones for the Azure Firewall.
    Example: ["1", "2", "3"] for zone redundancy.
    Requires Standard or Premium SKU.
  EOT
  type        = list(string)
  default     = ["1", "2", "3"]
}

################################################################################
# IP Configuration (VNet Deployment)
################################################################################

variable "subnet_id" {
  description = <<-EOT
    (Required for AZFW_VNet) The ID of the AzureFirewallSubnet.
    DEPENDENCY: Subnet named "AzureFirewallSubnet" must exist with minimum /26 prefix.
  EOT
  type        = string
  default     = null
}

variable "public_ip_count" {
  description = "(Optional) Number of Public IPs to create for the firewall."
  type        = number
  default     = 1

  validation {
    condition     = var.public_ip_count >= 1 && var.public_ip_count <= 250
    error_message = "public_ip_count must be between 1 and 250."
  }
}

variable "public_ip_ids" {
  description = <<-EOT
    (Optional) List of existing Public IP IDs to use instead of creating new ones.
    DEPENDENCY: Public IPs must be Standard SKU, Static allocation, in same region.
    If provided, public_ip_count is ignored.
  EOT
  type        = list(string)
  default     = []
}

variable "public_ip_name_prefix" {
  description = "(Optional) Prefix for created Public IP names."
  type        = string
  default     = "pip-afw"
}

################################################################################
# Management IP Configuration (Forced Tunneling)
################################################################################

variable "management_ip_configuration" {
  description = <<-EOT
    (Optional) Management IP configuration for forced tunneling scenarios.
    DEPENDENCY: Management subnet (AzureFirewallManagementSubnet) and Public IP must exist.

    Attributes:
      - subnet_id: The ID of the AzureFirewallManagementSubnet.
      - public_ip_address_id: The ID of the management Public IP.
  EOT
  type = object({
    subnet_id            = string
    public_ip_address_id = string
  })
  default = null
}

################################################################################
# Virtual Hub Configuration (Hub Deployment)
################################################################################

variable "virtual_hub" {
  description = <<-EOT
    (Required for AZFW_Hub) Virtual Hub configuration.
    DEPENDENCY: Virtual Hub must exist.

    Attributes:
      - virtual_hub_id: The ID of the Virtual Hub.
      - public_ip_count: Number of public IPs (1-100).
  EOT
  type = object({
    virtual_hub_id  = string
    public_ip_count = optional(number, 1)
  })
  default = null
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
# Diagnostic Settings (Optional)
################################################################################

variable "diagnostic_settings" {
  description = <<-EOT
    (Optional) Diagnostic settings configuration.
    DEPENDENCY: Log Analytics Workspace, Storage Account, or Event Hub must exist.
  EOT
  type = object({
    name                           = optional(string, "diag-afw")
    log_analytics_workspace_id     = optional(string, null)
    storage_account_id             = optional(string, null)
    eventhub_authorization_rule_id = optional(string, null)
    eventhub_name                  = optional(string, null)
    log_categories = optional(list(string), [
      "AzureFirewallApplicationRule",
      "AzureFirewallNetworkRule",
      "AzureFirewallDnsProxy",
      "AZFWNetworkRule",
      "AZFWApplicationRule",
      "AZFWNatRule",
      "AZFWThreatIntel",
      "AZFWIdpsSignature",
      "AZFWDnsQuery",
      "AZFWFqdnResolveFailure",
      "AZFWFatFlow",
      "AZFWFlowTrace"
    ])
    metric_categories = optional(list(string), ["AllMetrics"])
  })
  default = null
}
