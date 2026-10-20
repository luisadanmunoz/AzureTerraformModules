#############################################################################
# VARIABLES COGNITIVE ACCOUNT CUSTOMER MANAGED KEY
#############################################################################
variable "cognitive_account_id" {
  description = "value to set the cognitive account id"
  type        = string
}

variable "key_vault_key_id" {
  description = "value to set the key vault key id"
  type        = string
}

variable "identity_client_id" {
  description = "value to set the identity client id"
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
