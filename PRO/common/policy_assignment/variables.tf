#############################################################################
# VARIABLES POLICY ASSIGMENT
#############################################################################

variable "name" {
  description = "value of the name tag"
  type        = string
}
variable "policy_definition_id" {
  description = "value of the policy definition id tag"
  type        = string
  default     = null
}
variable "management_group_id" {
  description = "value of the management group id tag"
  //default = {}
  type = string
}

variable "location" {
  description = "value of the location tag"
  type        = string
}
variable "display_name" {
  description = "value of the display name tag"
  type        = string
}
variable "description" {
  description = "value of the description tag"
  type        = string
}
variable "parameters" {
  description = "value of the parameters tag"
  default     = {}
}
variable "policy_type" {
  description = "Tipo de política: 'definition' para una política única o 'set_definition' para un conjunto de políticas"
  type        = string
  default     = "definition"
}
variable "identity" {
  description = "value of the identity tag"
  type        = bool
}
variable "identity_ids" {
  description = "value of the identity ids tag"
  type        = set(string)
}
