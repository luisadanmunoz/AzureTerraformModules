#############################################################################
# VARIABLES COGNITIVE ACCOUNT RAI POLICY
#############################################################################
variable "cognitive_account_rai_policy_name" {
  description = "value to set the cognitive account rai policy name"
  type        = string
}

variable "cognitive_account_id" {
  description = "value to set the cognitive account id"
  type        = string
}

variable "base_policy_name" {
  description = "value to set the base policy name"
  type        = string
}

variable "mode" {
  description = "value to set the mode"
  type        = string
  default     = null
}

variable "content_filter" {
  description = "value to set the content filter"
  type = list(object({
    name               = string
    filter_enabled     = bool
    block_enabled      = bool
    severity_threshold = string
    source             = string
  }))
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
