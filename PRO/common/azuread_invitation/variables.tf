#############################################################################
# VARIABLES AZUREAD INVITATION
#############################################################################

variable "user_display_name" {
  description = "value of the user display name"
  type        = string
}
variable "user_email_address" {
  description = "value of the user email address"
  type        = string
}

/*
variable "additional_recipients" {
  type = string
}
*/

#############################################################################
# VARIABLES AZUREAD USER
#############################################################################


variable "user_principal_name" {
  description = "value of the user principal name"
  type        = string
}


#############################################################################
# VARIABLES AZUREAD GROUP MEMBER
#############################################################################

variable "group_object_id" {
  description = "value of the group object id"
  type        = string
}
