#############################################################################
# VARIABLES AVAILABILITY SET
#############################################################################
variable "availability_set_name" {
  description = "value to set the availability set name"
  type        = string
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "location" {
  description = "value to set the location"
  type        = string
}

variable "managed" {
  description = "value to set the managed"
  type        = bool
  default     = null
}

variable "platform_fault_domain_count" {
  description = "value to set the platform fault domain count"
  type        = number
  default     = null
}

variable "platform_update_domain_count" {
  description = "value to set the platform update domain count"
  type        = number
  default     = null
}

variable "proximity_placement_group_id" {
  description = "value to set the proximity placement group id"
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
