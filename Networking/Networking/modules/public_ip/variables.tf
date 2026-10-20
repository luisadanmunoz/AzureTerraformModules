#############################################################################
# VARIABLES PUBLIC IP
#############################################################################
variable "public_ip_name" {
  description = "value to set the public ip name"
  type        = string
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "location" {
  description = "value to set the location"
  type        = string
}

variable "allocation_method" {
  description = "value to set the allocation method"
  type        = string
}

variable "sku" {
  description = "value to set the sku"
  type        = string
  default     = "Standard"
}

variable "sku_tier" {
  description = "value to set the sku tier"
  type        = string
  default     = "Regional"
}

variable "domain_name_label" {
  description = "value to set the domain name label"
  type        = string
  default     = null
}

variable "reverse_fqdn" {
  description = "value to set the reverse fqdn"
  type        = string
  default     = null
}

variable "ip_version" {
  description = "value to set the ip version"
  type        = string
  default     = "IPv4"
}

variable "idle_timeout_in_minutes" {
  description = "value to set the idle timeout"
  type        = number
  default     = 4
}

variable "zones" {
  description = "value to set the zones"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
