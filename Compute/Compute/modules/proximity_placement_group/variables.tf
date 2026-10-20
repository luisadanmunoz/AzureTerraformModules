#############################################################################
# VARIABLES PROXIMITY PLACEMENT GROUP
#############################################################################
variable "proximity_placement_group_name" {
  description = "value to set the proximity placement group name"
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

variable "allowed_vm_sizes" {
  description = "value to set the allowed vm sizes"
  type        = list(string)
  default     = null
}

variable "zone" {
  description = "value to set the zone"
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
