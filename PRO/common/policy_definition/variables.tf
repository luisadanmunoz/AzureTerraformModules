#############################################################################
# VARIABLES POLICY DEFINITION
#############################################################################

variable "name" {
  description = "value of the name tag"
  type        = string
}
variable "policy_type" {
  description = "value of the policy type tag"
  type        = string
}
variable "description" {
  description = "value of the description tag"
  type        = string
}
variable "mode" {
  description = "value of the mode tag"
  type        = string
}
variable "display_name" {
  description = "value of the display name tag"
  type        = string
}
variable "management_group_id" {
  description = "value of the management group id tag"
  default     = {}
}
variable "policy_rule" {
  description = "value of the policy rule tag"
  type        = string
}
#############################################################################
# VARIABLES MANAGEMENT GROUP POLICY ASSIGNMENT
#############################################################################

variable "location" {
  description = "value of the location tag"
  type        = string
}
variable "identity" {
  description = "value of the identity tag"
  type        = bool
}
variable "identity_ids" {
  description = "value of the identity ids tag"
  type        = set(string)
}


