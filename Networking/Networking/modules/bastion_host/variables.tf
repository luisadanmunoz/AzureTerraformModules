#############################################################################
# VARIABLES BASTION HOST
#############################################################################
variable "bastion_host_name" {
  description = "value to set the bastion host name"
  type        = string

  validation {
    condition     = trimspace(var.bastion_host_name) != ""
    error_message = "bastion_host_name must not be empty."
  }
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "location" {
  description = "value to set the location"
  type        = string
}

variable "subnet_id" {
  description = "value to set the subnet id"
  type        = string

  validation {
    condition     = trimspace(var.subnet_id) != "" && startswith(var.subnet_id, "/subscriptions/")
    error_message = "subnet_id must be a valid Azure resource id."
  }
}

variable "public_ip_id" {
  description = "value to set the public ip id"
  type        = string

  validation {
    condition     = trimspace(var.public_ip_id) != "" && startswith(var.public_ip_id, "/subscriptions/")
    error_message = "public_ip_id must be a valid Azure resource id."
  }
}

variable "sku" {
  description = "value to set the bastion sku"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Developer", "Premium", "Standard"], var.sku)
    error_message = "sku must be one of Basic, Developer, Premium or Standard."
  }
}

variable "scale_units" {
  description = "value to set the scale units"
  type        = number
  default     = 2

  validation {
    condition     = var.scale_units >= 2
    error_message = "scale_units must be greater than or equal to 2."
  }
}

variable "copy_paste_enabled" {
  description = "value to enable copy paste"
  type        = bool
  default     = true
}

variable "file_copy_enabled" {
  description = "value to enable file copy"
  type        = bool
  default     = false
}

variable "ip_connect_enabled" {
  description = "value to enable ip connect"
  type        = bool
  default     = false
}

variable "shareable_link_enabled" {
  description = "value to enable shareable link"
  type        = bool
  default     = false
}

variable "tunneling_enabled" {
  description = "value to enable native client tunneling"
  type        = bool
  default     = false
}

variable "zones" {
  description = "value to set availability zones"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
