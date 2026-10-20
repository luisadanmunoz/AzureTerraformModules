#############################################################################
# APP SERVICE PLAN - VARIABLES
#############################################################################

variable "name_app_service_plan" {
  default = {}
}
variable "resource_group_name" {
  default = {}
}
variable "location" {
  default = {}
}
variable "tags" {
  type    = map(any)
  default = {}
}
#############################################################################
# FUNCTION APP - VARIABLES
#############################################################################

variable "name_function_app" {
  default = {}
}
variable "storage_account_name" {
  default = {}
}
variable "storage_account_access_key" {
  default = {}
}
/*
variable "AzureWebJobsStorage" {
  default = {}
}
*/
#############################################################################
# PRIVATE ENDPOINT - VARIABLES
#############################################################################

variable "subnet_id" {
  default = {}
}

variable "private_dns_zone_ids" {
  default = {}
}