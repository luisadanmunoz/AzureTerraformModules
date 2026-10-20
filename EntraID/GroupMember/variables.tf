################################################################################
# Required Variables
################################################################################

variable "group_object_id" {
  description = "The object ID of the group to add the member to."
  type        = string
}

variable "member_object_id" {
  description = "The object ID of the member (user, group, service principal, or device)."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the group membership."
  type        = bool
  default     = true
}
