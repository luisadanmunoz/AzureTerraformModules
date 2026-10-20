#############################################################################
# RECOVERY SERVICE VAULT VARIABLES
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
variable "sku" {
  type = string
}
variable "tags" {
  type    = map(any)
  default = {}
}
#############################################################################
# RECOVERY SERVICE VAULT OUTPUT POLICY VM
#############################################################################
variable "name_policy" {
  type = string
}
variable "recovery_vault_name" {
  type = string
}
variable "timezone" {
  type = string
}
variable "frequency" {
  type = string
}
variable "time" {
  type = string
}
variable "retention_daily" {
  type = number
}
/*
variable "retention_weekly" {
  type = number 
}
variable "weekdays_weekly" {
  type = set(string)
}

variable "retention_monthly" {
  type = number 
}
variable "weekdays_monthly" {
  type = set(string)
}
variable "weeks_monthly" {
  type = set(string)
}
variable "retention_yearly" {
  type = number
}
variable "retention_yearly_weekdays" {
  type = set(string)
}
variable "retention_yearly_weeks" {
  type = set(string)
}
variable "retention_yearly_months" {
  type = set(string)
}
#############################################################################
# DIAGNOSTIC SETTINGS
#############################################################################
variable "name_diagnostic_setting" {
  type = string
}
variable "workspace_resource_id" {
  type = string
}
*/

