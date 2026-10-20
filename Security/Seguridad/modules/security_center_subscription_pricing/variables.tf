#############################################################################
# VARIABLES SECURITY CENTER SUBSCRIPTION PRICING
#############################################################################
variable "tier" {
  description = "value to set the tier"
  type        = string
}

variable "resource_type" {
  description = "value to set the resource type"
  type        = string
  default     = null
}

variable "subplan" {
  description = "value to set the subplan"
  type        = string
  default     = null
}

variable "extensions" {
  description = "value to set the extensions"
  type = list(object({
    name                            = string
    additional_extension_properties = optional(map(string))
  }))
  default = []
}

variable "timeouts" {
  description = "value to set the timeouts"
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}
