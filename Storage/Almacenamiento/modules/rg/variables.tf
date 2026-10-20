#############################################################################
# VARIABLES RESOURCE GROUP
#############################################################################
variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "location" {
  description = "value to set the location"
  type        = string
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
