#############################################################################
# VARIABLES PRIVATE DNS ZONE
#############################################################################
variable "private_dns_zone_name" {
  description = "value to set the private dns zone name"
  type        = string
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
