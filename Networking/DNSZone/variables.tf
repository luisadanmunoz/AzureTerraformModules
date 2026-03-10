################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the DNS Zone."
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

variable "name" {
  description = "(Required) The name of the DNS Zone (e.g., 'contoso.com')."
  type        = string
}

################################################################################
# DNS Zone Configuration
################################################################################

variable "soa_record" {
  description = <<-EOT
    (Optional) SOA record configuration.

    Attributes:
      - email: Contact email (format: hostmaster.domain.com).
      - expire_time: Expire time in seconds.
      - minimum_ttl: Minimum TTL.
      - refresh_time: Refresh time.
      - retry_time: Retry time.
      - ttl: SOA record TTL.
  EOT
  type = object({
    email        = string
    expire_time  = optional(number, 2419200)
    minimum_ttl  = optional(number, 300)
    refresh_time = optional(number, 3600)
    retry_time   = optional(number, 300)
    ttl          = optional(number, 3600)
  })
  default = null
}

################################################################################
# DNS Records
################################################################################

variable "a_records" {
  description = "(Optional) Map of A records."
  type = map(object({
    ttl     = optional(number, 300)
    records = list(string)
  }))
  default = {}
}

variable "aaaa_records" {
  description = "(Optional) Map of AAAA records."
  type = map(object({
    ttl     = optional(number, 300)
    records = list(string)
  }))
  default = {}
}

variable "caa_records" {
  description = "(Optional) Map of CAA records."
  type = map(object({
    ttl = optional(number, 300)
    records = list(object({
      flags = number
      tag   = string
      value = string
    }))
  }))
  default = {}
}

variable "cname_records" {
  description = "(Optional) Map of CNAME records."
  type = map(object({
    ttl    = optional(number, 300)
    record = string
  }))
  default = {}
}

variable "mx_records" {
  description = "(Optional) Map of MX records."
  type = map(object({
    ttl = optional(number, 300)
    records = list(object({
      preference = number
      exchange   = string
    }))
  }))
  default = {}
}

variable "ns_records" {
  description = "(Optional) Map of NS records (besides zone apex)."
  type = map(object({
    ttl     = optional(number, 172800)
    records = list(string)
  }))
  default = {}
}

variable "ptr_records" {
  description = "(Optional) Map of PTR records."
  type = map(object({
    ttl     = optional(number, 300)
    records = list(string)
  }))
  default = {}
}

variable "srv_records" {
  description = "(Optional) Map of SRV records."
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
  description = "(Optional) Map of TXT records."
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
  description = "(Optional) Tags to assign to resources."
  type        = map(string)
  default     = {}
}
