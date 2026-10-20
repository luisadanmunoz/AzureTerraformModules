#############################################################################
# VARIABLES RESOURCE PROVIDER REGISTRATION
#############################################################################
variable "resource_provider_name" {
  description = "value to set the resource provider name"
  type        = string

  validation {
    condition     = can(regex("^Microsoft\\.", var.resource_provider_name))
    error_message = "resource_provider_name must start with Microsoft."
  }
}
