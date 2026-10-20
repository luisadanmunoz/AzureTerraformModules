# #############################################################################
# MONITOR ACTIVITY LOG ALERT VARIABLES
# #############################################################################
variable "name" {
  description = "value of the name tag"
  type        = string
}
variable "resource_group_name" {
  description = "value of the resource group name tag"
  type        = string
}
variable "scopes" {
  description = "value of the scopes tag"
  type        = set(string)
}
variable "description" {
  description = "value of the description tag"
  type        = string
}
variable "category" {
  description = "value of the category tag"
  type        = string
}
variable "location" {
  description = "value of the location tag"
  type        = string
}
/*
variable "operation_name" {
  type = string
}
variable "statuses" {
  type = list(string)
}
*/
variable "action_group_id" {
  description = "value of the action group id tag"
  type        = string
}