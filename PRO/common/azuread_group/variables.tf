#############################################################################
# VARIABLES AZUREAD GROUP
#############################################################################

variable "group_name" {
  description = "value of the azuread group name"
  type        = string
}
variable "owners" {
  description = "value of the azuread group owners"
  type        = set(string)
}