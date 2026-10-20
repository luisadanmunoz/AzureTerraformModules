#############################################################################
# MONITOR METRIC ALERT VARIABLES
#############################################################################
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
  type        = any
}
variable "description" {
  description = "value of the description tag"
  type        = string
}
variable "metric_namespace" {
  description = "value of the metric namespace tag"
  type        = string
}
variable "metric_name" {
  description = "value of the metric name tag"
  type        = string
}
variable "aggregation" {
  description = "value of the aggregation tag"
  type        = string
}
variable "operator" {
  description = "value of the operator tag"
  type        = string
}
variable "threshold" {
  description = "value of the threshold tag"
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
variable "action_group_id" {
  description = "value of the action group id tag"
  type        = string
}
variable "frequency" {
  description = "value of the frequency tag"
  type        = string
}
variable "window_size" {
  description = "value of the window size tag"
  type        = string
}
variable "auto_mitigate" {
  description = "value of the auto mitigate tag"
  type        = string
}