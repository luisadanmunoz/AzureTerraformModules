#############################################################################
# VARIABLES ASSIGNED IDENTITY
#############################################################################
variable "name" {
  description = "value of the user assigned identity name"
  type        = string
}
variable "resource_group_name" {
  description = "value of the user assigned identity resource group name"
  type        = string
}
variable "location" {
  description = "value of the user assigned identity location"
  type        = string
}
variable "tags" {
  description = "value of the user assigned identity tags"
  type        = map(any)
  default     = {}
}