#############################################################################
# VARIABLES TAGS
#############################################################################
variable "workload_name" {
  description = "value to set the workload name"
  type        = string
}

variable "environment" {
  description = "value to set the environment"
  type        = string
}

variable "owner" {
  description = "value to set the owner"
  type        = string
}

variable "cost_center" {
  description = "value to set the cost center"
  type        = string
}

variable "data_classification" {
  description = "value to set the data classification"
  type        = string
  default     = "internal"
}

variable "criticality" {
  description = "value to set the criticality"
  type        = string
  default     = "medium"
}

variable "managed_by" {
  description = "value to set the managed by"
  type        = string
  default     = "terraform"
}

variable "custom_tags" {
  description = "value to set the custom tags"
  type        = map(any)
  default     = {}
}
