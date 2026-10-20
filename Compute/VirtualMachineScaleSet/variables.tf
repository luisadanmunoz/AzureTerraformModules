################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Virtual Machine Scale Set."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the VMSS should exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Optional) The name of the VMSS. If not provided, a name will be generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for the generated name. Default: 'vmss'."
  type        = string
  default     = "vmss"
}

variable "workload" {
  description = "(Optional) Workload name for the naming convention."
  type        = string
  default     = "app"
}

variable "environment" {
  description = "(Optional) Environment name (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "instance" {
  description = "(Optional) Instance number for the naming convention."
  type        = string
  default     = "001"
}

################################################################################
# VMSS Configuration
################################################################################

variable "os_type" {
  description = "(Required) The OS type for the VMSS. Values: Linux, Windows."
  type        = string

  validation {
    condition     = contains(["Linux", "Windows"], var.os_type)
    error_message = "os_type must be either 'Linux' or 'Windows'."
  }
}

variable "sku" {
  description = "(Required) The SKU size for the instances (e.g., Standard_D2s_v5)."
  type        = string
}

variable "instances" {
  description = "(Optional) Number of VM instances. Default: 2."
  type        = number
  default     = 2
}

variable "zones" {
  description = "(Optional) List of Availability Zones for the VMSS."
  type        = list(string)
  default     = []
}

variable "zone_balance" {
  description = "(Optional) Balance instances across zones. Default: true."
  type        = bool
  default     = true
}

variable "proximity_placement_group_id" {
  description = "(Optional) The ID of the Proximity Placement Group. DEPENDENCY: PPG must exist."
  type        = string
  default     = null
}

variable "platform_fault_domain_count" {
  description = "(Optional) The number of fault domains. Default: null (Azure manages)."
  type        = number
  default     = null
}

variable "single_placement_group" {
  description = "(Optional) Use single placement group (max 100 VMs). Default: false."
  type        = bool
  default     = false
}

variable "overprovision" {
  description = "(Optional) Enable overprovisioning. Default: false."
  type        = bool
  default     = false
}

variable "upgrade_mode" {
  description = "(Optional) Upgrade mode. Values: Automatic, Manual, Rolling. Default: Manual."
  type        = string
  default     = "Manual"

  validation {
    condition     = contains(["Automatic", "Manual", "Rolling"], var.upgrade_mode)
    error_message = "upgrade_mode must be one of: Automatic, Manual, Rolling."
  }
}

variable "health_probe_id" {
  description = "(Optional) The ID of a Load Balancer Health Probe for rolling upgrades. DEPENDENCY: Health Probe must exist."
  type        = string
  default     = null
}

variable "scale_in" {
  description = <<-EOT
    (Optional) Scale-in policy configuration.
    - rule: Scale-in rule. Values: Default, NewestVM, OldestVM. Default: Default.
    - force_deletion_enabled: Force delete VMs on scale-in. Default: false.
  EOT
  type = object({
    rule                   = optional(string, "Default")
    force_deletion_enabled = optional(bool, false)
  })
  default = {}
}

################################################################################
# Admin Credentials
################################################################################

variable "admin_username" {
  description = "(Required) The admin username for the instances."
  type        = string
}

variable "admin_password" {
  description = "(Optional) The admin password. Required for Windows."
  type        = string
  default     = null
  sensitive   = true
}

variable "generate_admin_password" {
  description = "(Optional) Generate a random admin password. Default: true."
  type        = bool
  default     = true
}

variable "disable_password_authentication" {
  description = "(Optional) Disable password auth for Linux. Default: false."
  type        = bool
  default     = false
}

variable "admin_ssh_keys" {
  description = "(Optional) List of SSH public keys for Linux instances."
  type = list(object({
    username   = string
    public_key = string
  }))
  default = []
}

################################################################################
# Networking
################################################################################

variable "subnet_id" {
  description = "(Required) The Subnet ID for the instances. DEPENDENCY: Subnet must exist."
  type        = string
}

variable "enable_accelerated_networking" {
  description = "(Optional) Enable accelerated networking. Default: true."
  type        = bool
  default     = true
}

variable "load_balancer_backend_address_pool_ids" {
  description = "(Optional) List of Load Balancer Backend Pool IDs. DEPENDENCY: Backend pools must exist."
  type        = list(string)
  default     = []
}

variable "application_gateway_backend_address_pool_ids" {
  description = "(Optional) List of Application Gateway Backend Pool IDs. DEPENDENCY: Backend pools must exist."
  type        = list(string)
  default     = []
}

################################################################################
# OS Disk
################################################################################

variable "os_disk" {
  description = <<-EOT
    (Optional) OS disk configuration.
    - caching: Caching type. Default: ReadWrite.
    - storage_account_type: Disk type. Default: Premium_LRS.
    - disk_size_gb: Disk size in GB.
    - disk_encryption_set_id: Disk Encryption Set ID.
  EOT
  type = object({
    caching                = optional(string, "ReadWrite")
    storage_account_type   = optional(string, "Premium_LRS")
    disk_size_gb           = optional(number, null)
    disk_encryption_set_id = optional(string, null)
  })
  default = {}
}

################################################################################
# Source Image
################################################################################

variable "source_image_reference" {
  description = "(Optional) Source image reference from Marketplace."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = optional(string, "latest")
  })
  default = null
}

variable "source_image_id" {
  description = "(Optional) The ID of a custom image. DEPENDENCY: Image must exist."
  type        = string
  default     = null
}

################################################################################
# Data Disks
################################################################################

variable "data_disks" {
  description = "(Optional) List of data disks."
  type = list(object({
    lun                    = number
    disk_size_gb           = number
    storage_account_type   = optional(string, "Premium_LRS")
    caching                = optional(string, "ReadWrite")
    create_option          = optional(string, "Empty")
    disk_encryption_set_id = optional(string, null)
  }))
  default = []
}

################################################################################
# Boot Diagnostics
################################################################################

variable "boot_diagnostics" {
  description = "(Optional) Boot diagnostics configuration."
  type = object({
    enabled             = optional(bool, true)
    storage_account_uri = optional(string, null)
  })
  default = {}
}

################################################################################
# Identity
################################################################################

variable "identity" {
  description = "(Optional) Identity configuration."
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = null
}

################################################################################
# Autoscale
################################################################################

variable "autoscale" {
  description = <<-EOT
    (Optional) Autoscale settings.
    - enabled: Enable autoscaling. Default: false.
    - min_count: Minimum instance count.
    - max_count: Maximum instance count.
    - default_count: Default instance count.
    - scale_out_cpu_threshold: CPU % to scale out. Default: 75.
    - scale_in_cpu_threshold: CPU % to scale in. Default: 25.
  EOT
  type = object({
    enabled                 = optional(bool, false)
    min_count               = optional(number, 1)
    max_count               = optional(number, 10)
    default_count           = optional(number, 2)
    scale_out_cpu_threshold = optional(number, 75)
    scale_in_cpu_threshold  = optional(number, 25)
  })
  default = {}
}

################################################################################
# Security
################################################################################

variable "secure_boot_enabled" {
  description = "(Optional) Enable Secure Boot. Default: false."
  type        = bool
  default     = false
}

variable "vtpm_enabled" {
  description = "(Optional) Enable vTPM. Default: false."
  type        = bool
  default     = false
}

variable "encryption_at_host_enabled" {
  description = "(Optional) Enable encryption at host. Default: false."
  type        = bool
  default     = false
}

################################################################################
# Extensions
################################################################################

variable "extensions" {
  description = "(Optional) List of VM extensions."
  type = list(object({
    name                       = string
    publisher                  = string
    type                       = string
    type_handler_version       = string
    auto_upgrade_minor_version = optional(bool, true)
    settings                   = optional(string, null)
    protected_settings         = optional(string, null)
  }))
  default   = []
  sensitive = true
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
