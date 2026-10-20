################################################################################
# Required Variables
################################################################################

variable "display_name" {
  description = "The display name for the group."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the group."
  type        = bool
  default     = true
}

################################################################################
# Optional - Group Configuration
################################################################################

variable "description" {
  description = "A description for the group."
  type        = string
  default     = null
}

variable "security_enabled" {
  description = "Whether the group is a security group."
  type        = bool
  default     = true
}

variable "mail_enabled" {
  description = "Whether the group is mail-enabled."
  type        = bool
  default     = false
}

variable "mail_nickname" {
  description = "The mail alias for the group, unique in the organization."
  type        = string
  default     = null
}

variable "types" {
  description = "A set of group types to configure. Possible values: DynamicMembership, Unified."
  type        = set(string)
  default     = []
}

variable "assignable_to_role" {
  description = "Whether the group can be assigned to an Azure AD role."
  type        = bool
  default     = false
}

variable "behaviors" {
  description = "A set of behaviors for a Microsoft 365 group."
  type        = set(string)
  default     = []
}

variable "owners" {
  description = "A set of object IDs of principals that will be granted ownership."
  type        = set(string)
  default     = []
}

variable "members" {
  description = "A set of object IDs of members to add to the group."
  type        = set(string)
  default     = []
}

variable "prevent_duplicate_names" {
  description = "If true, will return an error if an existing group is found with the same name."
  type        = bool
  default     = true
}

variable "visibility" {
  description = "The group visibility. Possible values: Private, Public, Hiddenmembership."
  type        = string
  default     = null
}

variable "external_senders_allowed" {
  description = "Whether external senders can send messages to the group (Microsoft 365 groups only)."
  type        = bool
  default     = null
}

variable "auto_subscribe_new_members" {
  description = "Whether new members are auto-subscribed to receive email notifications (Microsoft 365 groups only)."
  type        = bool
  default     = null
}

variable "hide_from_address_lists" {
  description = "Whether the group is hidden from the global address list."
  type        = bool
  default     = null
}

variable "hide_from_outlook_clients" {
  description = "Whether the group is hidden from Outlook clients."
  type        = bool
  default     = null
}

variable "onpremises_group_type" {
  description = "The on-premises group type for directory sync."
  type        = string
  default     = null
}

variable "writeback_enabled" {
  description = "Whether writeback is enabled for the group."
  type        = bool
  default     = null
}

################################################################################
# Optional - Dynamic Membership
################################################################################

variable "dynamic_membership" {
  description = "Dynamic membership rule for the group."
  type = object({
    enabled = bool
    rule    = string
  })
  default = null
}

################################################################################
# Optional - Provisioning Options
################################################################################

variable "provisioning_options" {
  description = "A set of provisioning options for a Microsoft 365 group."
  type        = set(string)
  default     = []
}

variable "theme" {
  description = "The theme color for a Microsoft 365 group."
  type        = string
  default     = null
}
