#############################################################################
# LOG ANALYTICS WORKSPACE
#############################################################################
variable "name" {
  description = "value of the name tag"
  type        = string
}

variable "location" {
  description = "value of the location tag"
  type        = string
}

variable "resource_group_name" {
  description = "value of the resource group name tag"
  type        = string
}

variable "sku" {
  description = "value of the sku tag"
  type        = string
}

variable "retention_in_days" {
  description = "value of the retention in days tag"
  type        = string
}

variable "tags" {
  description = "value of the tags tag"
  type        = map(any)
  default     = {}
}
