################################################################################
# Required Variables
################################################################################

# DEPENDENCY: Resource Group must exist
variable "resource_group_name" {
  description = "The name of the resource group where the Azure Firewall will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the Azure Firewall will be created."
  type        = string
}

################################################################################
# Optional Variables - Naming
################################################################################

variable "name" {
  description = "The name of the Azure Firewall. If not provided, a name will be generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix for the Azure Firewall name."
  type        = string
  default     = "fw"
}

variable "workload" {
  description = "The workload name for naming convention."
  type        = string
  default     = ""
}

variable "environment" {
  description = "The environment name (dev, staging, prod) for naming convention."
  type        = string
  default     = ""
}

variable "instance" {
  description = "The instance identifier for naming convention."
  type        = string
  default     = "001"
}

################################################################################
# Optional Variables - Configuration
################################################################################

variable "create" {
  description = "Controls whether resources should be created."
  type        = bool
  default     = true
}

variable "sku_name" {
  description = "The SKU name of the Azure Firewall. Possible values are AZFW_VNet and AZFW_Hub."
  type        = string
  default     = "AZFW_VNet"

  validation {
    condition     = contains(["AZFW_VNet", "AZFW_Hub"], var.sku_name)
    error_message = "SKU name must be AZFW_VNet or AZFW_Hub."
  }
}

variable "sku_tier" {
  description = "The SKU tier of the Azure Firewall. Possible values are Basic, Standard, and Premium."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku_tier)
    error_message = "SKU tier must be Basic, Standard, or Premium."
  }
}

variable "firewall_policy_id" {
  description = "The ID of the Firewall Policy applied to the Azure Firewall."
  type        = string
  default     = null
}

variable "dns_proxy_enabled" {
  description = "Whether DNS proxy is enabled on the Azure Firewall."
  type        = bool
  default     = null
}

variable "threat_intel_mode" {
  description = "The threat intelligence mode. Possible values are Alert, Deny, and Off."
  type        = string
  default     = "Alert"

  validation {
    condition     = contains(["Alert", "Deny", "Off"], var.threat_intel_mode)
    error_message = "Threat intelligence mode must be Alert, Deny, or Off."
  }
}

variable "zones" {
  description = "A list of availability zones where the Azure Firewall should be deployed."
  type        = list(string)
  default     = []
}

variable "ip_configuration" {
  description = "List of IP configuration blocks for the Azure Firewall."
  type = list(object({
    name                 = string
    subnet_id            = optional(string)
    public_ip_address_id = optional(string)
  }))
  default = []
}

variable "management_ip_configuration" {
  description = "Management IP configuration block for forced tunneling. Required when forced tunneling is enabled."
  type = object({
    name                 = string
    subnet_id            = string
    public_ip_address_id = string
  })
  default = null
}

variable "virtual_hub" {
  description = "Virtual Hub configuration for vWAN integration (AZFW_Hub SKU)."
  type = object({
    virtual_hub_id  = string
    public_ip_count = optional(number, 1)
  })
  default = null
}

################################################################################
# Optional Variables - Tags
################################################################################

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
