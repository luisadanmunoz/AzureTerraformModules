################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Virtual Machine."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Virtual Machine should exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Optional) The name of the Virtual Machine. If not provided, a name will be generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for the generated name. Default: 'vm'."
  type        = string
  default     = "vm"
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

variable "computer_name" {
  description = "(Optional) The computer name of the VM. Max 15 chars for Windows, 64 for Linux."
  type        = string
  default     = null
}

################################################################################
# VM Configuration
################################################################################

variable "os_type" {
  description = "(Required) The OS type for the VM. Values: Linux, Windows."
  type        = string

  validation {
    condition     = contains(["Linux", "Windows"], var.os_type)
    error_message = "os_type must be either 'Linux' or 'Windows'."
  }
}

variable "size" {
  description = "(Required) The SKU size for the Virtual Machine (e.g., Standard_D2s_v5)."
  type        = string
}

variable "zone" {
  description = "(Optional) The Availability Zone in which the VM should be located."
  type        = string
  default     = null
}

variable "availability_set_id" {
  description = "(Optional) The ID of the Availability Set. DEPENDENCY: Availability Set must exist."
  type        = string
  default     = null
}

variable "proximity_placement_group_id" {
  description = "(Optional) The ID of the Proximity Placement Group. DEPENDENCY: PPG must exist."
  type        = string
  default     = null
}

variable "dedicated_host_id" {
  description = "(Optional) The ID of the Dedicated Host. DEPENDENCY: Dedicated Host must exist."
  type        = string
  default     = null
}

variable "dedicated_host_group_id" {
  description = "(Optional) The ID of the Dedicated Host Group. DEPENDENCY: Dedicated Host Group must exist."
  type        = string
  default     = null
}

variable "capacity_reservation_group_id" {
  description = "(Optional) The ID of the Capacity Reservation Group. DEPENDENCY: Capacity Reservation Group must exist."
  type        = string
  default     = null
}

variable "license_type" {
  description = "(Optional) License type for hybrid benefit. Values: None, Windows_Client, Windows_Server, RHEL_BYOS, SLES_BYOS."
  type        = string
  default     = null
}

variable "priority" {
  description = "(Optional) VM priority. Values: Regular, Spot. Default: Regular."
  type        = string
  default     = "Regular"

  validation {
    condition     = contains(["Regular", "Spot"], var.priority)
    error_message = "priority must be either 'Regular' or 'Spot'."
  }
}

variable "eviction_policy" {
  description = "(Optional) Eviction policy for Spot VMs. Values: Deallocate, Delete."
  type        = string
  default     = null
}

variable "max_bid_price" {
  description = "(Optional) Maximum bid price for Spot VMs. -1 means current on-demand price."
  type        = number
  default     = -1
}

################################################################################
# Admin Credentials
################################################################################

variable "admin_username" {
  description = "(Required) The admin username for the VM."
  type        = string
}

variable "admin_password" {
  description = "(Optional) The admin password for the VM. Required for Windows, optional for Linux."
  type        = string
  default     = null
  sensitive   = true
}

variable "generate_admin_password" {
  description = "(Optional) Generate a random admin password. Default: true if admin_password not provided."
  type        = bool
  default     = true
}

variable "disable_password_authentication" {
  description = "(Optional) Disable password auth for Linux VMs. Default: false."
  type        = bool
  default     = false
}

variable "admin_ssh_keys" {
  description = <<-EOT
    (Optional) List of SSH public keys for Linux VMs.
    - username: The username for the SSH key.
    - public_key: The SSH public key.
  EOT
  type = list(object({
    username   = string
    public_key = string
  }))
  default = []
}

################################################################################
# Networking
################################################################################

variable "network_interface_ids" {
  description = "(Optional) List of Network Interface IDs. If not provided, a NIC will be created. DEPENDENCY: NICs must exist."
  type        = list(string)
  default     = []
}

variable "create_network_interface" {
  description = "(Optional) Create a Network Interface. Default: true if network_interface_ids not provided."
  type        = bool
  default     = true
}

variable "subnet_id" {
  description = "(Optional) The Subnet ID for the NIC. Required if create_network_interface is true. DEPENDENCY: Subnet must exist."
  type        = string
  default     = null
}

variable "private_ip_address" {
  description = "(Optional) The private IP address. If not set, Dynamic allocation is used."
  type        = string
  default     = null
}

variable "private_ip_address_allocation" {
  description = "(Optional) IP allocation method. Values: Dynamic, Static. Default: Dynamic."
  type        = string
  default     = "Dynamic"
}

variable "create_public_ip" {
  description = "(Optional) Create a Public IP for the VM. Default: false."
  type        = bool
  default     = false
}

variable "public_ip_sku" {
  description = "(Optional) SKU for the Public IP. Values: Basic, Standard. Default: Standard."
  type        = string
  default     = "Standard"
}

variable "enable_accelerated_networking" {
  description = "(Optional) Enable accelerated networking. Default: true."
  type        = bool
  default     = true
}

variable "enable_ip_forwarding" {
  description = "(Optional) Enable IP forwarding on the NIC. Default: false."
  type        = bool
  default     = false
}

################################################################################
# OS Disk
################################################################################

variable "os_disk" {
  description = <<-EOT
    (Optional) OS disk configuration.
    - name: OS disk name.
    - caching: Caching type. Values: None, ReadOnly, ReadWrite. Default: ReadWrite.
    - storage_account_type: Disk type. Default: Premium_LRS.
    - disk_size_gb: Disk size in GB.
    - disk_encryption_set_id: ID of the Disk Encryption Set.
    - write_accelerator_enabled: Enable write accelerator.
  EOT
  type = object({
    name                      = optional(string, null)
    caching                   = optional(string, "ReadWrite")
    storage_account_type      = optional(string, "Premium_LRS")
    disk_size_gb              = optional(number, null)
    disk_encryption_set_id    = optional(string, null)
    write_accelerator_enabled = optional(bool, false)
  })
  default = {}
}

################################################################################
# Source Image
################################################################################

variable "source_image_reference" {
  description = <<-EOT
    (Optional) Source image reference from Marketplace.
    - publisher: Image publisher.
    - offer: Image offer.
    - sku: Image SKU.
    - version: Image version. Default: latest.
  EOT
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = optional(string, "latest")
  })
  default = null
}

variable "source_image_id" {
  description = "(Optional) The ID of a custom image or Shared Image Gallery image. DEPENDENCY: Image must exist."
  type        = string
  default     = null
}

################################################################################
# Data Disks
################################################################################

variable "data_disks" {
  description = <<-EOT
    (Optional) List of data disks to attach.
    - name: Disk name.
    - disk_size_gb: Disk size in GB.
    - storage_account_type: Disk type. Default: Premium_LRS.
    - caching: Caching type. Default: ReadWrite.
    - lun: Logical Unit Number.
    - create_option: Create option. Default: Empty.
  EOT
  type = list(object({
    name                   = optional(string, null)
    disk_size_gb           = number
    storage_account_type   = optional(string, "Premium_LRS")
    caching                = optional(string, "ReadWrite")
    lun                    = number
    create_option          = optional(string, "Empty")
    disk_encryption_set_id = optional(string, null)
  }))
  default = []
}

################################################################################
# Boot Diagnostics
################################################################################

variable "boot_diagnostics" {
  description = <<-EOT
    (Optional) Boot diagnostics configuration.
    - enabled: Enable boot diagnostics. Default: true.
    - storage_account_uri: Storage account URI. If null, managed storage is used.
  EOT
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
  description = <<-EOT
    (Optional) Identity configuration.
    - type: Type of identity. Values: SystemAssigned, UserAssigned, SystemAssigned, UserAssigned.
    - identity_ids: List of User Assigned Identity IDs.
  EOT
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = null
}

################################################################################
# Security
################################################################################

variable "secure_boot_enabled" {
  description = "(Optional) Enable Secure Boot for Trusted Launch. Default: false."
  type        = bool
  default     = false
}

variable "vtpm_enabled" {
  description = "(Optional) Enable vTPM for Trusted Launch. Default: false."
  type        = bool
  default     = false
}

variable "encryption_at_host_enabled" {
  description = "(Optional) Enable encryption at host. Default: false."
  type        = bool
  default     = false
}

variable "patch_mode" {
  description = "(Optional) Patch mode. Windows: Manual, AutomaticByOS, AutomaticByPlatform. Linux: ImageDefault, AutomaticByPlatform."
  type        = string
  default     = null
}

variable "patch_assessment_mode" {
  description = "(Optional) Patch assessment mode. Values: ImageDefault, AutomaticByPlatform."
  type        = string
  default     = null
}

################################################################################
# Extensions
################################################################################

variable "extensions" {
  description = <<-EOT
    (Optional) List of VM extensions to install.
    - name: Extension name.
    - publisher: Extension publisher.
    - type: Extension type.
    - type_handler_version: Extension version.
    - auto_upgrade_minor_version: Auto upgrade. Default: true.
    - settings: JSON settings.
    - protected_settings: JSON protected settings.
  EOT
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
