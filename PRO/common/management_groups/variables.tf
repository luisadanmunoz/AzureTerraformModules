#############################################################################
# VARIABLES POLICY DEFINITION INTERMEDIATE_ROOT
#############################################################################
variable "name_management_group_Intermediate_Root" {
  description = "value of the name tag"
  type        = string
}
/*
variable "parent_management_group_id_Intermediate_Root" {
  type = string
  default = null
}
*/
variable "subscription_ids_Intermediate_Root" {
  description = "value of the subscription id tag"
  type        = set(string)
  default     = null
}
#############################################################################
# VARIABLES POLICY DEFINITION PLATFORM
#############################################################################
variable "name_management_group_Platform" {
  description = "value of the name tag"
  type        = string
}
/*
variable "parent_management_group_id_Platform" {
  type = string
  default = null
}
*/
variable "subscription_ids_Platform" {
  description = "value of the subscription id tag"
  type        = set(string)
  default     = null
}
#############################################################################
# VARIABLES POLICY DEFINITION IDENTITY
#############################################################################
variable "name_management_group_Identity" {
  description = "value of the name tag"
  type        = string
}
/*
variable "parent_management_group_id_Identity" {
  type = string
  default = null
}
*/
variable "subscription_ids_Identity" {
  description = "value of the subscription id tag"
  type        = set(string)
  default     = null
}
#############################################################################
# VARIABLES POLICY DEFINITION MANAGEMENT
#############################################################################
variable "name_management_group_Management" {
  description = "value of the name tag"
  type        = string
}
/*
variable "parent_management_group_id_Management" {
  type = string
  default = null
}
*/
variable "subscription_ids_Management" {
  description = "value of the subscription id tag"
  type        = set(string)
  default     = null
}
#############################################################################
# VARIABLES POLICY DEFINITION CONNECTIVIY
#############################################################################
variable "name_management_group_Connectivity" {
  description = "value of the name tag"
  type        = string
}
/*
variable "parent_management_group_id_Connectivity" {
  type = string
  default = null
}
*/
variable "subscription_ids_Connectivity" {
  description = "value of the subscription id tag"
  type        = set(string)
  default     = null
}
#############################################################################
# VARIABLES POLICY DEFINITION LANDING ZONES
#############################################################################
variable "name_management_group_Landing_Zones" {
  description = "value of the name tag"
  type        = string
}
/*
variable "parent_management_group_id_Landing_Zones" {
  type = string
  default = null
}
*/
variable "subscription_ids_Landing_Zones" {
  description = "value of the subscription id tag"
  type        = set(string)
  default     = null
}