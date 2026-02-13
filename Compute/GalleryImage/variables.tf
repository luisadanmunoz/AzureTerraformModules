################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Gallery Image Definition."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Image should exist."
  type        = string
}

variable "gallery_name" {
  description = "(Required) The name of the Shared Image Gallery. DEPENDENCY: Gallery must exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Required) The name of the Gallery Image Definition."
  type        = string
}

################################################################################
# Image Configuration
################################################################################

variable "os_type" {
  description = "(Required) The OS type. Values: Linux, Windows."
  type        = string

  validation {
    condition     = contains(["Linux", "Windows"], var.os_type)
    error_message = "os_type must be either 'Linux' or 'Windows'."
  }
}

variable "hyper_v_generation" {
  description = "(Optional) The Hyper-V generation. Values: V1, V2. Default: V2."
  type        = string
  default     = "V2"

  validation {
    condition     = contains(["V1", "V2"], var.hyper_v_generation)
    error_message = "hyper_v_generation must be either 'V1' or 'V2'."
  }
}

variable "architecture" {
  description = "(Optional) CPU architecture. Values: x64, Arm64. Default: x64."
  type        = string
  default     = "x64"
}

variable "identifier" {
  description = <<-EOT
    (Required) Image identifier.
    - publisher: Image publisher name.
    - offer: Image offer name.
    - sku: Image SKU name.
  EOT
  type = object({
    publisher = string
    offer     = string
    sku       = string
  })
}

variable "description" {
  description = "(Optional) A description of the Gallery Image Definition."
  type        = string
  default     = null
}

variable "eula" {
  description = "(Optional) The End User License Agreement for the Gallery Image."
  type        = string
  default     = null
}

variable "privacy_statement_uri" {
  description = "(Optional) The URI of the privacy statement."
  type        = string
  default     = null
}

variable "release_note_uri" {
  description = "(Optional) The URI of the release notes."
  type        = string
  default     = null
}

variable "specialized" {
  description = "(Optional) Is the image specialized. Default: false."
  type        = bool
  default     = false
}

variable "trusted_launch_enabled" {
  description = "(Optional) Enable Trusted Launch. Default: false."
  type        = bool
  default     = false
}

variable "accelerated_network_support_enabled" {
  description = "(Optional) Enable accelerated networking. Default: false."
  type        = bool
  default     = false
}

variable "confidential_vm_enabled" {
  description = "(Optional) Enable Confidential VM. Default: false."
  type        = bool
  default     = false
}

variable "confidential_vm_supported" {
  description = "(Optional) Is Confidential VM supported. Default: false."
  type        = bool
  default     = false
}

variable "min_recommended_vcpu_count" {
  description = "(Optional) Minimum recommended vCPU count."
  type        = number
  default     = null
}

variable "max_recommended_vcpu_count" {
  description = "(Optional) Maximum recommended vCPU count."
  type        = number
  default     = null
}

variable "min_recommended_memory_in_gb" {
  description = "(Optional) Minimum recommended memory in GB."
  type        = number
  default     = null
}

variable "max_recommended_memory_in_gb" {
  description = "(Optional) Maximum recommended memory in GB."
  type        = number
  default     = null
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
