#############################################################################
# MONITOR SCHEDULED QUERY RULES ALERT VARIABLES
#############################################################################
variable "name" {
  description = "value of the name tag"
  type        = string
}
variable "resource_group_name" {
  description = "value of the resource group name tag"
  type        = string
}
variable "location" {
  description = "value of the location tag"
  type        = string
}
variable "severity" {
  description = "value of the severity tag"
  type        = string
}
variable "enabled" {
  description = "value of the enabled tag"
  type        = string
}
variable "description" {
  description = "value of the description tag"
  type        = string
}
variable "log_analytics" {
  description = "value of the log analytics tag"
  type        = string
}
variable "query" {
  description = "value of the query tag"
  type        = string
}
variable "time_window" {
  description = "value of the time window tag"
  type        = string
}
variable "frequency" {
  description = "value of the frequency tag"
  type        = string
}
variable "threshold" {
  description = "value of the threshold tag"
  type        = string
}
variable "operator" {
  description = "value of the operator tag"
  type        = string
}
variable "action_group_id" {
  description = "value of the action group id tag"
  type        = set(string)
}
