#############################################################################
# VARIABLES VIRTUAL MACHINE DATA DISK ATTACHMENT
#############################################################################
variable "managed_disk_id" {
  description = "value to set the managed disk id"
  type        = string
}

variable "virtual_machine_id" {
  description = "value to set the virtual machine id"
  type        = string
}

variable "lun" {
  description = "value to set the lun"
  type        = number
}

variable "caching" {
  description = "value to set the caching"
  type        = string
}

variable "create_option" {
  description = "value to set the create option"
  type        = string
  default     = null
}

variable "write_accelerator_enabled" {
  description = "value to set the write accelerator enabled"
  type        = bool
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
