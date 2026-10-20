#############################################################################
# PUBLIC IP VARIABLES
#############################################################################
variable "name" {
  type = string
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "allocation_method" {
  type = string
}
variable "sku" {
  type = string
}
variable "zones" {
  default = {}
}
variable "tags" {
  type    = map(any)
  default = {}
}
#############################################################################
# PUBLIC IP VARIABLES DIAGNOSTIC SETTING
#############################################################################
variable "name_diagnostic_setting" {
  default = {}
}
variable "workspace_resource_id" {
  default = {}
}