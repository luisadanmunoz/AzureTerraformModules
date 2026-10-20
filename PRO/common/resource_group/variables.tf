#############################################################################
# RESOURCE GROUP VARIABLES
#############################################################################
variable "resource_group_name" {
  description = "value of the resource group name"
  type        = string
}
variable "location" {
  description = "value of the location"
  type        = string
}
variable "tags" {
  description = "value of the tags"
  type        = map(any)
  default     = {}
}