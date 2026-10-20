#############################################################################
# VARIABLES COGNITIVE ACCOUNT RAI BLOCKLIST
#############################################################################
variable "cognitive_account_rai_blocklist_name" {
  description = "value to set the cognitive account rai blocklist name"
  type        = string
}

variable "cognitive_account_id" {
  description = "value to set the cognitive account id"
  type        = string
}

variable "description" {
  description = "value to set the description"
  type        = string
  default     = null
}

variable "timeouts" {
  description = "value to set the timeouts"
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
