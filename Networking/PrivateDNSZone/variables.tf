################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Private DNS Zone."
  type        = bool
  default     = true
}

################################################################################
# Required Variables - Dependencies
################################################################################

variable "resource_group_name" {
  description = <<-EOT
    (Required) The name of the Resource Group where the Private DNS Zone will be created.
    DEPENDENCY: Resource Group must exist.
  EOT
  type        = string

  validation {
    condition     = var.resource_group_name != null && var.resource_group_name != ""
    error_message = "resource_group_name is required."
  }
}

################################################################################
# DNS Zone Configuration
################################################################################

variable "name" {
  description = <<-EOT
    (Required) The name of the Private DNS Zone (e.g., "privatelink.blob.core.windows.net").
    Must be a valid DNS zone name.
  EOT
  type        = string

  validation {
    condition     = var.name != null && var.name != ""
    error_message = "name is required."
  }
}

variable "soa_record" {
  description = <<-EOT
    (Optional) SOA record configuration for the DNS zone.

    Attributes:
      - email: Contact email for the zone.
      - expire_time: Time before expiry (default: 2419200).
      - minimum_ttl: Minimum TTL (default: 10).
      - refresh_time: Refresh time (default: 3600).
      - retry_time: Retry time (default: 300).
      - ttl: SOA record TTL (default: 3600).
  EOT
  type = object({
    email        = string
    expire_time  = optional(number, 2419200)
    minimum_ttl  = optional(number, 10)
    refresh_time = optional(number, 3600)
    retry_time   = optional(number, 300)
    ttl          = optional(number, 3600)
  })
  default = null
}

################################################################################
# Virtual Network Links
################################################################################

variable "virtual_network_links" {
  description = <<-EOT
    (Optional) Map of Virtual Network links to create.
    DEPENDENCY: Virtual Networks must exist.

    Attributes:
      - virtual_network_id: The ID of the Virtual Network to link.
      - registration_enabled: Enable auto-registration of VM records (default: false).
  EOT
  type = map(object({
    virtual_network_id    = string
    registration_enabled  = optional(bool, false)
  }))
  default = {}
}

################################################################################
# DNS Records
################################################################################

variable "a_records" {
  description = <<-EOT
    (Optional) Map of A records to create.

    Attributes:
      - ttl: Record TTL in seconds.
      - records: List of IPv4 addresses.
  EOT
  type = map(object({
    ttl     = optional(number, 300)
    records = list(string)
  }))
  default = {}
}

variable "aaaa_records" {
  description = <<-EOT
    (Optional) Map of AAAA records to create.

    Attributes:
      - ttl: Record TTL in seconds.
      - records: List of IPv6 addresses.
  EOT
  type = map(object({
    ttl     = optional(number, 300)
    records = list(string)
  }))
  default = {}
}

variable "cname_records" {
  description = <<-EOT
    (Optional) Map of CNAME records to create.

    Attributes:
      - ttl: Record TTL in seconds.
      - record: The target domain name.
  EOT
  type = map(object({
    ttl    = optional(number, 300)
    record = string
  }))
  default = {}
}

variable "mx_records" {
  description = <<-EOT
    (Optional) Map of MX records to create.

    Attributes:
      - ttl: Record TTL in seconds.
      - records: List of MX entries with preference and exchange.
  EOT
  type = map(object({
    ttl = optional(number, 300)
    records = list(object({
      preference = number
      exchange   = string
    }))
  }))
  default = {}
}

variable "ptr_records" {
  description = <<-EOT
    (Optional) Map of PTR records to create.

    Attributes:
      - ttl: Record TTL in seconds.
      - records: List of domain names.
  EOT
  type = map(object({
    ttl     = optional(number, 300)
    records = list(string)
  }))
  default = {}
}

variable "srv_records" {
  description = <<-EOT
    (Optional) Map of SRV records to create.

    Attributes:
      - ttl: Record TTL in seconds.
      - records: List of SRV entries.
  EOT
  type = map(object({
    ttl = optional(number, 300)
    records = list(object({
      priority = number
      weight   = number
      port     = number
      target   = string
    }))
  }))
  default = {}
}

variable "txt_records" {
  description = <<-EOT
    (Optional) Map of TXT records to create.

    Attributes:
      - ttl: Record TTL in seconds.
      - records: List of TXT values.
  EOT
  type = map(object({
    ttl     = optional(number, 300)
    records = list(string)
  }))
  default = {}
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A map of tags to assign to resources."
  type        = map(string)
  default     = {}
}
