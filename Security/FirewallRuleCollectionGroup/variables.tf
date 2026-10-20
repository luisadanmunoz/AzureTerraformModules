################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Firewall Policy Rule Collection Group."
  type        = string
}

# DEPENDENCY: Firewall Policy must exist
variable "firewall_policy_id" {
  description = "The ID of the Firewall Policy where the Rule Collection Group will be created."
  type        = string
}

variable "priority" {
  description = "The priority of the Rule Collection Group (100-65000). Lower values are processed first."
  type        = number

  validation {
    condition     = var.priority >= 100 && var.priority <= 65000
    error_message = "Priority must be between 100 and 65000."
  }
}

################################################################################
# Optional Variables - Configuration
################################################################################

variable "create" {
  description = "Controls whether resources should be created."
  type        = bool
  default     = true
}

variable "application_rule_collections" {
  description = "List of application rule collections for the Rule Collection Group."
  type = list(object({
    name     = string
    priority = number
    action   = string
    rules = list(object({
      name                  = string
      description           = optional(string)
      source_addresses      = optional(list(string))
      source_ip_groups      = optional(list(string))
      destination_fqdns     = optional(list(string))
      destination_fqdn_tags = optional(list(string))
      destination_urls      = optional(list(string))
      destination_addresses = optional(list(string))
      terminate_tls         = optional(bool)
      web_categories        = optional(list(string))
      protocols = optional(list(object({
        type = string
        port = number
      })))
    }))
  }))
  default = []
}

variable "network_rule_collections" {
  description = "List of network rule collections for the Rule Collection Group."
  type = list(object({
    name     = string
    priority = number
    action   = string
    rules = list(object({
      name                  = string
      description           = optional(string)
      source_addresses      = optional(list(string))
      source_ip_groups      = optional(list(string))
      destination_addresses = optional(list(string))
      destination_ip_groups = optional(list(string))
      destination_fqdns     = optional(list(string))
      destination_ports     = list(string)
      protocols             = list(string)
    }))
  }))
  default = []
}

variable "nat_rule_collections" {
  description = "List of NAT rule collections for the Rule Collection Group."
  type = list(object({
    name     = string
    priority = number
    action   = string
    rules = list(object({
      name                = string
      description         = optional(string)
      source_addresses    = optional(list(string))
      source_ip_groups    = optional(list(string))
      destination_address = optional(string)
      destination_ports   = optional(list(string))
      protocols           = list(string)
      translated_address  = optional(string)
      translated_fqdn    = optional(string)
      translated_port     = string
    }))
  }))
  default = []
}
